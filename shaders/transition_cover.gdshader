shader_type canvas_item;

uniform float opacity: hint_range(0.0, 1.0, 0.01);

void fragment() {
	COLOR = vec4(vec3(0), opacity);
}
