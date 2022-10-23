#version 330 core

uniform float iTime;
uniform vec2  iResolution;
uniform vec2  iMousePos;

in  vec3 FragPos;
out vec4 FragColor;

float hash21(vec2 uv)
{
    uv = fract(uv * vec2(173.83, 765.34));
    uv += dot(uv, uv + 571.37);
    return fract(uv.x * uv.y);
}

float tapperBox(vec2 uv, float bottomWidth, float bottomHeight, float topWidth, float topHeight, float edgeBlur)
{
    // bottom and top boundary
    float m = smoothstep(-edgeBlur, edgeBlur, uv.y - bottomHeight);
    m *= smoothstep(edgeBlur, -edgeBlur, uv.y - topHeight);

    uv.x = abs(uv.x);
    float linearWidth = mix(bottomWidth, topWidth, (uv.y - bottomHeight) / (topHeight - bottomHeight));
    m *= smoothstep(edgeBlur, -edgeBlur, uv.x - linearWidth);
    return m;
}

vec4 tree(vec2 uv, vec3 col, float blur)
{
    float m = 0.0;
    m += tapperBox(uv, 0.03, -0.05, 0.03, 0.25, blur); // trunk
    m += tapperBox(uv, 0.20,  0.25, 0.10, 0.50, blur); // leaf1
    m += tapperBox(uv, 0.15,  0.50, 0.05, 0.75, blur); // leaf2
    m += tapperBox(uv, 0.10,  0.75, 0.00, 1.00, blur); // leaf3

    float s = 0.0;
    s += tapperBox(uv - vec2(0.20, 0.0), 0.10, 0.15, 0.50, 0.25, blur); // shadow1
    s += tapperBox(uv + vec2(0.25, 0.0), 0.10, 0.45, 0.50, 0.50, blur); // shadow2
    s += tapperBox(uv - vec2(0.25, 0.0), 0.10, 0.70, 0.50, 0.75, blur); // shadow3

    col -= s * 0.7;
    return vec4(col, m);
}

float getHeight(float x)
{
    return sin(x * 0.223) + sin(x) * 0.31;
}

vec4 treeLayer(vec2 uv, float blur)
{
    vec4 col = vec4(0.0);
    float id = floor(uv.x);
    float randNum = fract(sin(id * 173.3) * 101.37) * 2.0 - 1.0;

    // ground
    float ground = smoothstep(0.005, -0.005, uv.y + getHeight(uv.x));
    col += ground;

    // trees
    uv.x = fract(uv.x) - 0.5;
    float offsetX = randNum * 0.3;
    float offsetY = -getHeight(id + 0.5 + offsetX);
    vec4 tree = tree((uv - vec2(offsetX, offsetY)) * vec2(1.0, 1.0 + randNum * 0.5), vec3(1.0), blur);

    col = mix(col, tree, tree.a);
    col.a = max(ground, tree.a);
    return col;
}

void main()
{
    vec2 uv = (FragPos.xy - 0.5 * iResolution) / iResolution.y;
    float t = iTime * 0.5;
    vec2 m = (iMousePos / iResolution) * 2.0 - 1.0; // add mouse control view port

    vec4 col = vec4(0.0);

    // stars
    float twinkle = dot(length(sin(uv + t)), length(cos(uv * vec2(17.0, 7.1) - t)));
    twinkle = sin(twinkle * 3.0) * 0.5 + 0.5;
    float stars = pow(hash21(uv), 100.0) * twinkle;
    col += stars;

    // moon
    float moon = smoothstep(0.01, -0.01, length(uv - vec2(0.4, 0.2)) - 0.15);
    col *= 1.0 - moon; // stars should be occluded by moon
    float cutout = smoothstep(-0.01, 0.1, length(uv - vec2(0.5, 0.25)) - 0.15);
    moon *= cutout;
    col += moon;

    // trees
    // back ground
    vec4 layer;
    for (float i = 0.0; i < 1.0; i += 1.0 / 10.0)
    {
        float scale = mix(30.0, 1.0, i);
        float blury = mix(0.1, 0.005, i);
        layer = treeLayer(uv * scale + vec2(t + i * 50.0, 0.0) - m, blury); // the further layer moves faster
        layer.rgb *= (1.0 - i) * vec3(0.87, 0.85, 1.0);
        col = mix(col, layer, layer.a); 
    }
    // fore ground
    layer = treeLayer(uv + vec2(t, 0.0) - m, 0.08);
    col = mix(col, layer * 0.1, layer.a);

    // draw a coordinate
    // float thickness = 1.0 / iResolution.y;
    // if (abs(uv.x) < thickness) col.g = 1.0;
    // if (abs(uv.y) < thickness) col.r = 1.0;
    FragColor = col;
}