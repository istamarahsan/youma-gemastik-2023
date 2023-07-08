shader_type canvas_item;

const uint STATE_IDLE    = uint(0);
const uint STATE_ACTIVE  = uint(1);
const uint STATE_SHOWING = uint(2);

uniform vec4 color: source_color = vec4(1);
uniform uint state = 0;
uniform float outline_width: hint_range(0.0, 1.0, 0.01) = float(1);

void fragment() {
	vec2 center = vec2(0.5);
	vec2 relative_position = UV - center;
	float distance_from_edge = 0.5 - distance(relative_position, vec2(0));
	float theta = degrees(atan(relative_position.y, relative_position.x));
	
	if (state == STATE_ACTIVE) {
		if (distance_from_edge >= 0.0 && distance_from_edge <= outline_width) {
//			vec4 base;
//			if (int(round(theta)) % 5 == 0) {
//				base = mod(TIME*1.5, 2) - 1.0 > 0.0 ? vec4(0) : color;
//			} else {
//				base = mod(TIME*1.5, 2) - 1.0 < 0.0 ? vec4(0) : color;
//			}
//			COLOR = base;
		}
	}
}
