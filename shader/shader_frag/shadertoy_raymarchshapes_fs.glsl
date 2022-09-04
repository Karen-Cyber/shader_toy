#version 330 core

uniform float iTime;
uniform vec2  iResolution;
uniform vec2  iMousePos;

in  vec3 FragPos;
out vec4 FragColor;

#define MAX_STEPS 100
#define MAX_DIST 100.0
#define EPSILON 0.001

float getSphereDist(vec3 point);
float getCapsuleDist(vec3 point, vec3 endA, vec3 endB, float radius);
vec3  getNormal(vec3 point);
float getLight(vec3 point);
float rayMarching(vec3 ro, vec3 rd);


void main()
{
    // move the origin to the center of the viewport
    // and compensate if the view port is not square
    vec2 uv = (FragPos.xy - 0.5 * iResolution) / iResolution.y;

    vec3 col = vec3(0.0);

    vec3 rayOrg = vec3(0.0, 2.0, 0.0);
    vec3 rayDir = vec3(uv.x, uv.y - 0.2, 1.0);

    float distToObj = rayMarching(rayOrg, rayDir);

    vec3 point = rayOrg + rayDir * distToObj;
    float diffuseLight = getLight(point);

    col = vec3(diffuseLight);

    FragColor = vec4(col, 1.0);
}

float getSphereDist(vec3 point)
{
    // define a sphere
    vec4 sphere = vec4(0.0, 1.0, 6.0, 1.0); // x, y, z, radius

    return length(point - sphere.xyz) - sphere.w;
}

float getCapsuleDist(vec3 point, vec3 endA, vec3 endB, float radius)
{
    vec3 AB = endB - endA;
    vec3 AP = point - endA;

    float t = dot(AB, AP) / dot(AB, AB);
    t = clamp(t, 0.0, 1.0);

    vec3 c = endA + t * AB;

    return length(point - c) - radius;
}

float getTorusDist(vec3 point, vec2 radiusBS)
{
    float x = length(point.xz) - radiusBS.x;
    return length(vec2(x, point.y)) - radiusBS.y;
}

float getCuboidDist(vec3 point, vec3 abc)
{
    // cuboid means '长方体'
    // 使用raymarching技术在着色器中表达长方体的碰撞非常简单
    // 可以看作是一个数学处理的trick，当我们行进中的探测点的
    // 位置在长方体某个平行于坐标轴面xy、yz或者zx的面所在的
    // 方柱(和圆柱类似的概念)中，这个点与立方体表面做外切圆时
    // ，半径就是行进点(x,y,z)中其中一个分量减去坐标系原点到
    // 长方体对应面距离的值。

    // 'abc' stands for the length, width, height
    return length(max(abs(point) - abc, vec3(0.0)));
}

// some more complicated for cylinder
float getCylinderDist(vec3 point, vec3 endA, vec3 endB, float radius)
{
    vec3 AB = endB - endA;
    vec3 AP = point - endA;

    float t = dot(AB, AP) / dot(AB, AB);

    vec3 c = endA + t * AB;

    float x = length(point - c) - radius;
    float y = (abs(t - 0.5) - 0.5) * length(AB);

    float externalDist = length(max(vec2(x, y), vec2(0.0))); // same trick concept used in cuboid
    float internalDist = min(max(x, y), 0.0);
    
    return internalDist + externalDist;
}

// adaptor
float getObjDist(vec3 point)
{
    float distObj;
    float distPln = point.y;

    // capsule
    float distCap = getCapsuleDist(point, vec3(0.0, 1.0, 6.0), vec3(1.0, 2.0, 6.0), 0.3);
    // sphere
    // distObj = getSphereDist(point);
    // torus
    float distTor = getTorusDist(point - vec3(0.0, 0.5, 6.0), vec2(1.5, 0.3));
    // cuboid
    float distCub = getCuboidDist(point - vec3(-3.0, 0.5, 6.0), vec3(0.5, 0.5, 0.5));
    // cylinder
    float distCyd = getCylinderDist(point, vec3(0.0, 0.3, 3.0), vec3(3.0, 0.3, 5.0), 0.3);

    distObj = min(distCap, distPln);
    distObj = min(distObj, distTor);
    distObj = min(distObj, distCub);
    distObj = min(distObj, distCyd);
    return distObj;
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
    float distLight = rayMarching(point + normlVec * EPSILON * 2.0, lightVec);
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

// if you are struggling with figuring out the concept
// just go to see this video, and you will figure them
// out quickly...

// https://www.youtube.com/watch?v=Ff0jJyyiVyw

// or search "The art of code" in the Youtube website.