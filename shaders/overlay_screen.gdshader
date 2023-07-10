shader_type canvas_item;

uniform float degree: hint_range(0.0, 1.0, 0.1);
uniform sampler2D screen: hint_screen_texture;

float blend_screen_f(float a, float b) {
	return 1.0-2.0*(1.0-a)*(1.0-b);
}

float blend_multiply_f(float a, float b) {
	return 2.0 * a * b;
}

vec3 blend_overlay(vec3 a, vec3 b) {
	return vec3(
		a.r < 0.5 ? blend_multiply_f(a.r, b.r) : blend_screen_f(a.r, b.r),
		a.g < 0.5 ? blend_multiply_f(a.g, b.g) : blend_screen_f(a.g, b.g),
		a.b < 0.5 ? blend_multiply_f(a.b, b.b) : blend_screen_f(a.b, b.b)
	);
}

void fragment() {
	vec4 source_p = texture(TEXTURE, UV);
	vec4 screen_p = texture(screen, SCREEN_UV);
	COLOR = source_p.a > 0.0 ? vec4(blend_overlay(screen_p.rgb, source_p.rgb), 1.0) : screen_p;
}

