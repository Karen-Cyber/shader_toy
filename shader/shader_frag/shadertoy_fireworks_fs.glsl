#version 330 core

uniform float iTime;
uniform vec2  iResolution;
uniform vec2  iMousePos;

in  vec3 FragPos;
out vec4 FragColor;

#define PARTICALS_NUM 75
#define FIREWORKS_NUM 3

// basically scatter in a square
vec2 hash12(float t)
{
    float x = fract(sin(t * 177.51) * 711.15);
    float y = fract(sin((t + x) * 211.13) * 513.17);
    return vec2(x, y);
}

// basically scatter in a circle
vec2 hash12Polar(float t)
{
    float a = fract(sin(t * 177.51) * 711.15) * 6.28318;
    float d = fract(sin((t + a) * 211.13) * 513.17);

    // transform back to Cartesian coodinate
    return vec2(sin(a), cos(a)) * d;
}

float explosion(vec2 uv, float moving)
{
    float col = 0.0;

    for (int i = 1; i <= PARTICALS_NUM; ++i)
    {
        // 'i' should not begin with 0, or the hash12 will always return 0
        vec2 dir = hash12Polar(float(i)) * 0.7;

        float d = length(uv - dir * moving * (1.75 - moving));
        float brightness = mix(0.0005, 0.0017, smoothstep(1.0, 0.0, moving));
        // flake
        brightness *= sin(moving * 33.7 + float(i) * 17.1) + 1.0;
        // faded
        brightness *= smoothstep(1.0, 0.75, moving);
        col += brightness / d;
    }

    return col;
}

void main()
{
    // move the origin to the center of the viewport
    // and compensate if the view port is not square
    vec2 uv = (FragPos.xy - 0.5 * iResolution) / iResolution.y;

    vec3 col = vec3(0.0);
    for (int i = 0; i < FIREWORKS_NUM; ++i)
    {
        float  t = iTime + float(i) / float(FIREWORKS_NUM);
        float ft = floor(t);
        vec2 offset = hash12(float(i + 1) + ft) - 0.5;
        offset *= vec2(1.77, 1.0); // reshape the scatter to fit the view port
        vec3 thisTimeColour = sin(vec3(0.34, 0.54, 0.43) * ft * 2.0) * 0.25 + 0.75;
        col += explosion(uv - offset, fract(t)) * thisTimeColour * 0.6;
        // col += 0.005 / length(uv - offset);
    }

    FragColor = vec4(col, 1.0);
}