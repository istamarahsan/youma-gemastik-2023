shader_type canvas_item;

uniform float degree: hint_range(0.0, 1.0, 0.01) = 0.0;

void fragment() {
	vec4 source = texture(TEXTURE, UV);
	float avg = (source.r + source.g + source.b) / 3.0;
	vec4 grayscaled = vec4(vec3(avg + 0.001), source.a);
	COLOR = mix(source, grayscaled, degree);
}
