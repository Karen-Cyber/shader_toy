#version 330 core

layout (location = 0) in vec3 aPos;

uniform vec2 iResolution;

out vec3 FragPos;

void main()
{
    FragPos = aPos;
    gl_Position = vec4((aPos.x / iResolution.x - 0.5) * 2.0, (aPos.y / iResolution.y - 0.5) * 2.0, aPos.z, 1.0);
    // transform the bottom left coordinate to NDC[-1.0, 1.0]
}