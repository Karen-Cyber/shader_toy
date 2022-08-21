#version 330 core

in  vec3 FragPos;
out vec4 FragColor;

uniform float iTime;
uniform vec2 iResolution;

vec4 Smiley(vec2 uv);
vec4 Smiley_Head(vec2 uv);
vec4 Smiley_Mouth(vec2 uv);
vec4 Smiley_Eye(vec2 uv);

float remap_linear(float a, float b, float c, float d, float t);
float remap_zerone(float a, float b, float t);
// uv_in_rect returns the new coordinate based
// on a rectangle, whose origin is bottom left
// and this new coordinate is nomalized [0, 1]
vec2 uv_in_rect(vec2 uv, vec4 rect);


void main()
{
	vec2 uv = vec2(FragPos.x / iResolution.x, FragPos.y / iResolution.y);
    // compensate when view port is not a square
    uv.x *=  iResolution.x / iResolution.y;
    // the distance between current pixel and the center of the view port
    uv -= vec2(0.5, 0.5);

    // create the mirro effect, every thing drawed on one side
    // will be copy in the other side too!
    uv.x = abs(uv.x);
    
    FragColor = Smiley(uv);
}

vec4 Smiley(vec2 uv)
{
    vec4 col = vec4(0.0);
    vec4 hed = Smiley_Head(uv);
    vec4 eye = Smiley_Eye(uv_in_rect(uv, vec4(0.03, -0.1, 0.37, 0.25)));
    vec4 mou = Smiley_Mouth(uv_in_rect(uv, vec4(-0.3, -0.4, 0.3, -0.1)));

    // blend all components together
    col = mix(col, hed, hed.a);
    col = mix(col, eye, eye.a);
    col = mix(col, mou, mou.a);
    return col;
}

vec4 Smiley_Head(vec2 uv)
{
    float d = length(uv);
    vec4 col = vec4(0.9, 0.65, 0.1, 1.0);
    // use smoothstep function to create
    // boundary check, all pixels greter
    // than this distance is black.
    col.a = smoothstep(0.5, 0.49, d);

    // now let's create the gradual change effect
    float edgeShade = remap_zerone(0.35, 0.5, d);
    col.rgb *= 1.0 - edgeShade * edgeShade * 0.5;

    // and add an edge
    col.rgb = mix(col.rgb, vec3(0.6, 0.3, 0.1), smoothstep(0.482, 0.49, d));

    // highligth part and opaque effect
    float highligth = smoothstep(0.41, 0.405, d);
    highligth *= remap_linear(0.41, -0.1, 0.75, 0.0, uv.y);
    col.rgb = mix(col.rgb, vec3(1.0, 1.0, 1.0), highligth);

    // cheek part
    d = length(uv - vec2(0.25, -0.20));
    float cheek = smoothstep(0.2, 0.01, d) * 0.4;
    cheek *= smoothstep(0.17, 0.16, d);
    col.rgb = mix(col.rgb, vec3(1.0, 0.1, 0.1), cheek);
    return col;
}
vec4 Smiley_Mouth(vec2 uv)
{
    uv -= vec2(0.5);
    float d = length(uv);
    vec4 col = vec4(0.5, 0.18, 0.05, 1.0);

    // stretch the box, you can imagine that:
    // if a pixel(x,y)(normalized) has a length of length(uv),
    // which means the distance to origin is 0.5 to draw the 
    // colour within the boundary, than this line:
    // uv.y -= uv.x * uv.x * 2.0;
    // makes a pixel must be higher to obtain a bigger uv.y to
    // reach a distance of 0.5 to the origin, that's why when
    // this line combined with smoothstep, it makes a stretch
    // effect.
    uv.y *= 1.5;
    uv.y -= uv.x * uv.x * 2.5;

    // this time clipping takes place ahead, you can think that
    // this line means outside the specified area, all paints 
    // are opaque thus will not be seen.
    d = length(uv);
    col.a = smoothstep(0.5, 0.48, d);

    float teeth = length(uv - vec2(0.0, 0.6));
    vec3 teeth_shadow = vec3(1.0) * smoothstep(0.6, 0.35, d);
    col.rgb = mix(col.rgb, teeth_shadow, smoothstep(0.4, 0.37, teeth));

    // tougne
    teeth = length(uv - vec2(0.0, -0.5));
    col.rgb = mix(col.rgb, vec3(1.0, 0.5, 0.5), smoothstep(0.5, 0.2, teeth));
    return col;
}
vec4 Smiley_Eye(vec2 uv)
{
    vec4 col = vec4(1.0);
    // remember we pass a normalized coordinate
    // into this eye function
    // let's transform it into NDC format, which
    // means put the origin at the center instead
    // of bottom left
    uv -= vec2(0.5, 0.5);
    float d = length(uv);
    
    vec4 irisCol = vec4(0.3, 0.5, 1.0, 1.0);
    col = mix(col, irisCol, smoothstep(0.1, 0.7, d) * 0.4);

    // shadow, first we made a shadow of circle, and we only
    // want the upper part of it, so we can multiply by uv.y
    // and clamp uv.y to [0.0, 1.0]
    col.rgb *= 1.0 - smoothstep(0.45, 0.5, d) * 0.5 * clamp(-uv.y-uv.x, 0.0, 1.0);

    // cetner pupil
    col.rgb = mix(col.rgb, vec3(0.0), smoothstep(0.3, 0.28, d));
    irisCol.rgb *= 1.0 + smoothstep(0.3, 0.05, d);
    col.rgb = mix(col.rgb, irisCol.rgb, smoothstep(0.28, 0.26, d));
    col.rgb = mix(col.rgb, vec3(0.0), smoothstep(0.16, 0.14, d));

    // highlight
    float highlight = smoothstep(0.1, 0.09, length(uv - vec2(-0.15, 0.15)));
    // the second highlight
    highlight += smoothstep(0.07, 0.05, length(uv - vec2(0.08, -0.08)));
    col.rgb = mix(col.rgb, vec3(1.0), highlight);
    // clipping is applied at the last
    // to avoid other influence above
    col.a = smoothstep(0.5, 0.48, d);
    return col;
}

// utility
float remap_linear(float a, float b, float c, float d, float t)
{
    return clamp((t - a) / (b - a), 0.0, 1.0) * (d - c) + c;
}
float remap_zerone(float a, float b, float t)
{
    return clamp((t - a) / (b - a), 0.0, 1.0);
}
vec2 uv_in_rect(vec2 uv, vec4 rect)
{
    return (uv.xy - rect.xy) / (rect.zw - rect.xy);
}
