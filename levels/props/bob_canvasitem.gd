extends Node

@export var target: CanvasItem
@export var max_offset: float = 0
@export var normal_height: float = 0
@export_range(0, 10, 0.01) var time_offset: float = 0
@export_range(0, 1, 0.01) var amplitude: float = 0.5

const min_amp_down: float = 500.0
const max_amp_down: float = 2000.0

func _process(_delta):
	var top: float = -max_offset
	var bottom: float = max_offset
	var scale: float = lerpf(min_amp_down, max_amp_down, 1-amplitude)
	var x = (Time.get_ticks_msec() + (time_offset*60)) / scale
	var step: float = sin(x)/2.0 + 0.5
	var offset = lerpf(
		top, 
		bottom, 
		step
		)
	target.position.y = normal_height + offset
