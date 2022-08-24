#version 330 core

#define STAR_LAYERS 6

uniform float iTime;
uniform vec2  iResolution;
uniform vec2  iMousePos;

in  vec3 FragPos;
out vec4 FragColor;

mat2 rotateHorizontal(float angle)
{
    return mat2(
        cos(angle), -sin(angle),
        sin(angle),  cos(angle)
    );
}

float hash21(vec2 uv)
{
    uv = fract(uv * vec2(123.34, 456.21));
    uv += dot(uv, uv + 45.32);
    return fract(uv.x * uv.y);
}

float crossStar(vec2 uv, float flare)
{
    float d = length(uv);

    // core light
    float m = 0.05 / d;

    // cross rays
    float cross_rays1 = max(0.0, 1.0 - abs(uv.x * uv.y * 1000.0));
    m += cross_rays1 * flare;
    uv *= rotateHorizontal(radians(45.0));
    float cross_rays2 = max(0.0, 0.8 - abs(uv.x * uv.y * 1000.0));
    m += cross_rays2 * flare / (10.0 * d);

    m *= smoothstep(0.6, 0.2, d);

    return m;
}

vec3 starLayer(vec2 uv)
{
    vec3 col = vec3(0.0);
    vec2 gv = fract(uv) - 0.5;

    // debug: draw boundary of each repeated box
    // if (gv.x > 0.49 || gv.y > 0.49) col.r = 1.0;
    // col.rg += id * 0.2;
    // col += hash21(uv);

    vec2 id = floor(uv);

    // add neighbors' colour attribution to center box
    for (int i = -1; i <= 1; ++i)
    {
        for (int j = -1; j <= 1; ++j)
        {
            vec2 offset = vec2(i, j);
            float randomPos = hash21(id + offset); // random value between 0.0 to 1.0
            float glareSize = fract(randomPos * 17.1);
            float star = crossStar(gv - offset - vec2(randomPos, fract(randomPos * 177.17)) + 0.5, smoothstep(0.75, 0.95, glareSize));

            vec3 randomCol = sin(vec3(0.2, 0.3, 0.9) * fract(randomPos * 17.7) * 17.7) * 0.5 + 0.5; // each component of the vector3 will be applied sin func
            // do the colour filter
            randomCol = randomCol * vec3(1.0, 0.3, 1.0 + glareSize * 0.5);
            col += star * glareSize * randomCol;
        }
    }

    return col;
}

void main()
{
    vec2 uv = vec2(FragPos.x / iResolution.x, FragPos.y / iResolution.y);
    // the distance between current pixel and the center of the view port
    uv -= vec2(0.5, 0.5);
    // compensate when view port is not a square
    uv.x *=  iResolution.x / iResolution.y;
    vec2 normalizedMousePos = (iMousePos.xy - iResolution.xy * 0.5) / iResolution.y;
    uv += normalizedMousePos * 0.2;
    uv *= rotateHorizontal(iTime * 0.1);


    vec3 col = vec3(0.0);

    for (float i = 0.0; i < 1.0; i += 1.0 / STAR_LAYERS)
    {
        float depth = fract(i + iTime * 0.1);
        // the smaller the 'scale', the smaller the uv
        // and gap between star will get larger because
        // of that
        float scale = mix(20.0, 0.5, depth); 
        float faded = depth * smoothstep(1.0, 0.9, depth); // smoothly fade out
        col += starLayer(uv * scale + i * 177.7) * faded;
    }    

    FragColor = vec4(col, 1.0);
}