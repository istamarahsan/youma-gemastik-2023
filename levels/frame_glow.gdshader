shader_type canvas_item;

uniform vec4 color: source_color;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	float strength = max(UV.y - 0.5, 0) * 2.0;
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	COLOR = vec4(screen_color.rgb + (vec3(0.3 * strength)), screen_color.a);
}
