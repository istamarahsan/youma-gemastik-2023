shader_type canvas_item;

const uint STATE_IDLE    = uint(0);
const uint STATE_ACTIVE  = uint(1);
const uint STATE_SHOWING = uint(2);

uniform vec4 color: source_color = vec4(1);
uniform uint state = 0;
uniform float outline_width: hint_range(0.0, 0.5, 0.001) = float(0.01);
uniform float radius: hint_range(0.0, 0.5, 0.01) = float(0.8);
uniform float rotation_speed: hint_range(0.0, 500.0, 1.0) = float(200);

void fragment() {
	vec2 center = vec2(0.5);
	vec2 relative_position = UV - center;
	float distance_from_center = distance(UV, center);
	float distance_from_edge = abs(radius - distance_from_center);
	float outline_step = smoothstep(0.0, outline_width, distance_from_edge);
	float theta = degrees(atan(relative_position.y, relative_position.x));
	
	COLOR = distance_from_edge < outline_width
		? vec4(color.rgb, smoothstep(-180, 180, mod(theta + TIME * rotation_speed, 360.0) - 180.0))
		: vec4(0);
//	float distance_from_edge = 0.5 - distance(relative_position, vec2(0));
//	float theta = degrees(atan(relative_position.y, relative_position.x));
	
}
