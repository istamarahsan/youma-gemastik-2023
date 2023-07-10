shader_type canvas_item;

uniform sampler2D screen: hint_screen_texture;

void fragment() {
	COLOR = texture(TEXTURE, UV) * texture(screen, SCREEN_UV);
}