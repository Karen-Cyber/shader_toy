#version 330 core

uniform float iTime;
uniform vec2  iResolution;
uniform vec2  iMousePos;

in  vec3 FragPos;
out vec4 FragColor;

#define MAX_STEPS 100
#define MAX_DIST 100.0
#define EPSILON 0.001

float getObjDist(vec3 point);
vec3  getNormal(vec3 point);
float getLight(vec3 point);
float rayMarching(vec3 ro, vec3 rd);


void main()
{
    // move the origin to the center of the viewport
    // and compensate if the view port is not square
    vec2 uv = (FragPos.xy - 0.5 * iResolution) / iResolution.y;

    vec3 col = vec3(0.0);

    vec3 rayOrg = vec3(0.0, 1.0, 0.0);
    vec3 rayDir = vec3(uv.x, uv.y, 1.0);

    float distToObj = rayMarching(rayOrg, rayDir);

    vec3 point = rayOrg + rayDir * distToObj;
    float diffuseLight = getLight(point);

    col = vec3(diffuseLight); // to make values smaller than 1.0
    // col = getNormal(point);
    FragColor = vec4(col, 1.0);
}

float getObjDist(vec3 point)
{
    // define a sphere
    vec4 sphere = vec4(0.0, 1.0, 6.0, 1.0); // x, y, z, radius
    float distSphere = length(point - sphere.xyz) - sphere.w;
    float distPlane = point.y;

    return min(distSphere, distPlane);
}

vec3 getNormal(vec3 point)
{
    float dist = getObjDist(point);
    vec2 offset = vec2(0.01, 0.0);

    vec3 normal = dist - vec3(
        getObjDist(point - offset.xyy),
        getObjDist(point - offset.yxy),
        getObjDist(point - offset.yyx)
    );

    return normalize(normal);
}

float getLight(vec3 point)
{
    vec3 lightPos = vec3(0.0, 5.0, 6.0);
    lightPos.xz += vec2(sin(iTime), cos(iTime)) * 2;
    vec3 lightVec = normalize(lightPos - point);
    vec3 normlVec = getNormal(point);

    float diffuseFactor = clamp(dot(normlVec, lightVec), 0.0, 1.0);

    // decide wether the point is in the shadow
    float distLight = rayMarching(point + normlVec * EPSILON, lightVec);
    if (distLight < length(lightPos - point))
        diffuseFactor *= 0.1;

    return diffuseFactor;
}

float rayMarching(vec3 ro, vec3 rd)
{
    float distOrg = 0.0;
    float distObj = 0.0;
    vec3 point;
    for (int i = 0; i < MAX_STEPS; ++i)
    {
        point = ro + rd * distOrg;
        distObj = getObjDist(point);
        distOrg += distObj;
        if (distOrg > MAX_DIST || distObj < EPSILON)
            break;
    }

    return distOrg;
}