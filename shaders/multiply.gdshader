shader_type canvas_item;

uniform sampler2D mask;

void fragment() {
	vec4 mask_rgba = texture(mask, UV);
	vec4 self_rgba = texture(TEXTURE, UV);
	if (mask_rgba.a != 0.0) {
		COLOR = vec4(mask_rgba.rgb * self_rgba.rgb, self_rgba.a);
	}
	else {
		COLOR = self_rgba;
	}
}
