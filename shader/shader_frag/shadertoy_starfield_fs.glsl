#version 330 core

uniform float iTime;
uniform vec2  iResolution;

in  vec3 FragPos;
out vec4 FragColor;

void main()
{
    vec2 uv = vec2(FragPos.x / iResolution.x, FragPos.y / iResolution.y);
    // compensate when view port is not a square
    uv.x *=  iResolution.x / iResolution.y;
    // the distance between current pixel and the center of the view port
    uv -= vec2(0.5, 0.5);
    vec3 col = vec3(0.0);
    float d = length(uv);
    float m = smoothstep(0.1, 0.05, d);
    col += m;
    FragColor = vec4(col, 1.0);
}