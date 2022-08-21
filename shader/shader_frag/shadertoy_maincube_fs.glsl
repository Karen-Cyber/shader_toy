#version 330 core
out vec4 FragColor;

in vec2 TexCoord;

// texture samplers
uniform sampler2D shadertoy_tex;

void main()
{
	FragColor = texture(shadertoy_tex, TexCoord);
	// FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}