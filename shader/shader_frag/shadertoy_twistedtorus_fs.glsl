#version 330 core

uniform float iTime;
uniform vec2  iResolution;
uniform vec2  iMousePos;

in  vec3 FragPos;
out vec4 FragColor;

void main()
{
    vec2 uv = (FragPos.xy - 0.5 * iResolution) / iResolution.y;
    float t = iTime * 0.2;
    uv *= mat2(cos(t), -sin(t), sin(t), cos(t));
    vec3 col = vec3(0.0);

    vec3 rayOrg = vec3(0.0, 0.0, -1.0);
    vec3 lookAt = mix(vec3(0.0), vec3(-1.0, 0.0, -1.0), sin(t * 0.5) * 0.5 + 0.5);
    float zoomd = mix(0.2, 0.7, sin(t) * 0.5 + 0.5);

    vec3 camFront = normalize(lookAt - rayOrg);
    vec3 camRight = normalize(cross(vec3(0.0, 1.0, 0.0), camFront));
    vec3 camUp    = cross(camFront, camRight);

    vec3 virtCent = rayOrg + camFront * zoomd;
    vec3 intercet = virtCent + uv.x * camRight + uv.y * camUp;

    vec3 rayDir = normalize(intercet - rayOrg);

    float distSrf = 0.0;
    float distOrg = 0.0;
    vec3 p = vec3(0.0);
    float torusRadius = mix(0.5, 1.5, sin(t) * 0.5 + 0.5);
    for (int i = 0; i < 100; ++i)
    {
        p = rayOrg + rayDir * distOrg;
        distSrf = (length(vec2(length(p.xz) - 1.0, p.y)) - torusRadius) * -1.0; // if we are inner a shape
        if (distSrf < 0.001) break;
        distOrg += distSrf;
    }
    if (distSrf < 0.001)
    {
        // get some textures
        float horizonTex = atan(p.x, p.z) + t * 2.0;
        float verticaTex = atan(length(p.xz) - 1.0, p.y);
        // repeat the textures
        float twistedTex = sin(verticaTex * 10.0 + horizonTex * 30.0);
        // shaper the textures
        float sharpenTex = smoothstep(-0.2, 0.2, twistedTex);
        float intervaTex = smoothstep(-0.2, 0.2, twistedTex - 0.5);
        // other decorations
        float ripplesTex = sin((horizonTex * 10.0 - verticaTex * 30.0) * 3.0) * 0.5 + 0.5;
        float wavdingTex = sin(horizonTex * 2.0 - verticaTex * 6.0 + t * 10.0);


        col += sharpenTex * (1.0 - intervaTex);
        col += ripplesTex * intervaTex * max(0.0, wavdingTex);
        col += max(0.0, wavdingTex * intervaTex * 0.3);

        col = mix(col, 1.0 - col, smoothstep(-0.3, 0.3, sin(horizonTex * 2.0 + t)));
    }

    FragColor = vec4(col, 1.0);
}