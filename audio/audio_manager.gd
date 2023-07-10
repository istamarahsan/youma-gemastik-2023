extends Node

signal scale_changed

var _sfx_scale: float = 1
var _music_scale: float = 1

@export_range(0, 1, 0.01) var sfx_scale: float:
	get:
		return _sfx_scale
	set(value):
		_sfx_scale = clampf(value, 0, 1)
		scale_changed.emit()
@export_range(0, 1, 0.01) var music_scale: float:
	get:
		return _music_scale
	set(value):
		_music_scale = clampf(value, 0, 1)
		scale_changed.emit()

func _ready():
	scale_changed.emit()
