@tool
extends Node2D
class_name PropAutoFade

@export var sprite: NodePath
@export_range(0.1, 10, 0.1) var fade_seconds: float = 0.5
@export_range(0, 1, 0.01) var opacity:
	set(value):
		var node = get_node_or_null(sprite) as Sprite2D
		if node == null:
			return
		node.modulate.a = value
	get:
		var node = get_node_or_null(sprite) as Sprite2D
		if node == null:
			return
		return node.modulate.a
@onready var _sprite: Sprite2D = get_node(sprite) as Sprite2D
var fading: bool = false
var fading_out: bool = false
var time_elapsed: float = 0.0

func fade_in():
	if fading:
		_reset()
	fading = true
	fading_out = false

func fade_out():
	if fading:
		_reset()
	fading = true
	fading_out = true

func _process(delta):
	if not fading:
		return
	if time_elapsed >= fade_seconds:
		_reset()
		return
	var opacity = lerpf(
		1 if fading_out else 0, 
		0 if fading_out else 1, 
		time_elapsed / fade_seconds)
	_sprite.modulate.a = opacity
	time_elapsed += delta

func _reset():
	fading = false
	time_elapsed = 0
