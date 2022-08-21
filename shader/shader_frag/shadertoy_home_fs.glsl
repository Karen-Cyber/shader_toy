#version 330 core

in  vec3 FragPos;
out vec4 FragColor;

uniform float iTime;
uniform vec2 iResolution;
uniform vec2 iMouse;

struct ray
{
    vec3 origin;
    vec3 direct;
};

float noise(float t);

ray getRay(vec2 uv, vec3 camPos, vec3 lookAt, float zoom);

vec3 closetPoint(ray r, vec3 p);
float distToRay(ray r, vec3 p);

// draw lights
float Bokeh(ray r, vec3 p, float size, float blur);

vec3 streetLights(ray r, float t);
vec3 headLights(ray r, float t);
vec3 tailLights(ray r, float t);

void main()
{
    // get the NDC-form coordinate
    vec2 uv = FragPos.xy / iResolution.xy;
    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;

    vec2 mp = iMouse.xy / iResolution.xy;


    // camera settings
    vec3 camPos = vec3(0.5, 0.2, 0.0);
    vec3 lookAt = vec3(0.5, 0.2, 1.0);

    // draw a sphere and move it
    ray r = getRay(uv, camPos, lookAt, 2.0);
    // move the cycle and using fract to repeat
    float t = iTime * 0.1 + mp.x;
    vec3 col = vec3(0.0);

    // all sorts of things
    col += streetLights(r, t);
    col += headLights(r, t);
    // col += tailLights(r, t);

    FragColor = vec4(col, 1.0);
}

float noise(float t)
{
    return fract(sin(t * 3457.0) * 6457.0);
}

ray getRay(vec2 uv, vec3 camPos, vec3 lookAt, float zoom)
{
    ray ret_ray;
    ret_ray.origin = camPos;

    vec3 forward  = normalize(lookAt - camPos);
    vec3 right    = cross(vec3(0.0, 1.0, 0.0), forward);
    vec3 upward   = cross(forward, right);
    vec3 center   = camPos + forward * zoom;
    vec3 intercet = center + uv.x * right + uv.y * upward;

    ret_ray.direct = normalize(intercet - ret_ray.origin);
    return ret_ray;
}

vec3 closetPoint(ray r, vec3 p)
{
    return max(0.0, dot(p - r.origin, r.direct)) * r.direct;
}
float distToRay(ray r, vec3 p)
{
    return length(p - closetPoint(r, p));
}

float Bokeh(ray r, vec3 p, float size, float blur)
{
    // compensate for distance to keep
    // the size of circle not becoming
    // smaller at further distance.
    size *= length(p);

    float d = distToRay(r, p);
    // define the radius of sphere
    float c = smoothstep(size, size * (1.0 - blur), d);
    // 'c' means colour here
    // now let's make a brighter boundary
    c *= mix(0.7, 1.0, smoothstep(size * 0.8, size, d));
    return c;
}

vec3 streetLights(ray r, float t)
{
    // mirror the ray
    float side = step(r.direct.x, 0.0);
    r.direct.x = abs(r.direct.x);
    float s = 1.0 / 10.0;
    float m = 0.0;
    for (float i = 0.0; i < 1.0; i += s)
    {
        float ti = fract(t + i + side * s * 0.5);
        vec3 p = vec3(2.0, 2.0, 100.0 - ti * 100.0);
        // need a number that is 0.0 at further
        // 1.0 at closer, and we dont want a simple
        // linear changing, it happens that ti 
        // satisfy our request.
        m += Bokeh(r, p, 0.05, 0.1) * ti * ti * ti;
    }
    return vec3(1.0, 0.7, 0.2) * m;
}

vec3 headLights(ray r, float t)
{
    // float s = 1.0 / 30.0;
    // float m = 0.0;
    // for (float i = 0.0; i < 1.0; i += s)
    // {
    //     if (noise(i) > 0.1) continue;
    //     float ti = fract(t + i);
    //     // car width
    //     float w1 = 0.25;
    //     float w2 = w1 * 1.4;
    //     float zi = 100.0 - ti * 100.0;
    //     float fi = ti * ti * ti * ti * ti;
    //     // need a number that is 0.0 at further
    //     // 1.0 at closer, and we dont want a simple
    //     // linear changing, it happens that ti 
    //     // satisfy our request.

    //     float focus = smoothstep(0.9, 1.0, ti);
    //     float hsize = mix(0.05, 0.03, focus);

    //     m += Bokeh(r, vec3(-1.0 - w1, 0.15, zi), hsize, 0.1) * fi;
    //     m += Bokeh(r, vec3(-1.0 + w1, 0.15, zi), hsize, 0.1) * fi;

    //     m += Bokeh(r, vec3(-1.0 - w2, 0.15, zi), hsize, 0.1) * fi;
    //     m += Bokeh(r, vec3(-1.0 + w2, 0.15, zi), hsize, 0.1) * fi;

    //     // reflection from ground
    //     float headRef = 0.0;
    //     headRef += Bokeh(r, vec3(-1.0 - w2, -0.16, zi), hsize * 2.0, 0.8) * fi;
    //     headRef += Bokeh(r, vec3(-1.0 + w2, -0.16, zi), hsize * 2.0, 0.8) * fi;
    //     m += headRef * focus;
    // }
    // return vec3(0.5, 0.7, 1.0) * m;

    float s = 1.0 / 10.0;
    float m = 0.0;
    for (float i = 0.0; i < 1.0; i += s)
    {
        float ti = fract(t + i);
        vec3 p = vec3(2.0, -2.0, 100.0 - ti * 100.0);
        // need a number that is 0.0 at further
        // 1.0 at closer, and we dont want a simple
        // linear changing, it happens that ti 
        // satisfy our request.
        m += Bokeh(r, p, 0.05, 0.1) * ti * ti * ti;
    }
    return vec3(0.5, 0.7, 1.0) * m;
}

vec3 tailLights(ray r, float t)
{
    float s = 1.0 / 30.0;
    float m = 0.0;
    for (float i = 0.0; i < 1.0; i += s)
    {
        if (noise(i) > 0.1) continue;
        float ti = fract(t + i);
        // car width
        float w1 = 0.25;
        float w2 = w1 * 1.4;
        float zi = 100.0 - ti * 100.0;
        float fi = ti * ti * ti * ti * ti;
        // need a number that is 0.0 at further
        // 1.0 at closer, and we dont want a simple
        // linear changing, it happens that ti 
        // satisfy our request.

        float focus = smoothstep(0.9, 1.0, ti);
        float hsize = mix(0.05, 0.03, focus);

        float x = 1.5;

        m += Bokeh(r, vec3(x - w1, 0.15, zi), hsize, 0.1) * fi;
        m += Bokeh(r, vec3(x + w1, 0.15, zi), hsize, 0.1) * fi;

        m += Bokeh(r, vec3(x - w2, 0.15, zi), hsize, 0.1) * fi;
        m += Bokeh(r, vec3(x + w2, 0.15, zi), hsize, 0.1) * fi;

        // reflection from ground
        float headRef = 0.0;
        headRef += Bokeh(r, vec3(x - w2, -0.16, zi), hsize * 2.0, 0.8) * fi;
        headRef += Bokeh(r, vec3(x + w2, -0.16, zi), hsize * 2.0, 0.8) * fi;
        m += headRef * focus;
    }
    return vec3(1.0, 0.1, 0.1) * m;
}