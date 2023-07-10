@tool
extends Sprite2D

@export var clockwise: bool = true
@export var editor_rotate: bool = true
@export_range(0, 10, 0.1) var time_offset: float = 0
@export_range(0.1, 1, 0.01) var amplitude: float = 0.5

const min_amp_down: float = 5
const max_amp_down: float = 100

func _process(delta):
	if not editor_rotate and Engine.is_editor_hint():
		return
	var time = (Time.get_ticks_msec() / 60.0) if not Engine.is_editor_hint() else Time.get_unix_time_from_system()
	time += time_offset
	time = time / lerpf(min_amp_down, max_amp_down, 1-amplitude)
	rotation = fmod(time, 2 * PI) * -1 if not clockwise else 1
#	rotation += fmod(PI * delta * (-1 if not clockwise else 1) / lerpf(min_amp_down, max_amp_down, 1-amplitude), 2 * PI)
