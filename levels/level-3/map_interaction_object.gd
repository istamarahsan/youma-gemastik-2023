extends Sprite2D
class_name SpecialMapInterationObject

@export var area2D: Area2D
@export var action_menu: MapActionSelectMenu
@export_range(0.01, 5, 0.01) var grayout_time: float = 0.01

@export var normal_texture: Texture2D
@export var highlight_texture: Texture2D

var showing_menu: bool = false
var enabled: bool:
	set(value):
		texture = normal_texture if value else highlight_texture
		_enabled = value
	get:
		return _enabled
var _enabled: bool = true

var fading: bool = false
var time_elapsed: float = 0.0

signal pressed
signal sura_chosen
signal baya_chosen

func _unhandled_input(event):
	if action_menu != null and InputExtensions.input_is_left_click_or_touch(event):
		showing_menu = false
		action_menu.hide()

func _ready():
	if area2D == null or action_menu == null:
		return
	area2D.input_event.connect(
		func(_viewport, event, _shape): 
			if InputExtensions.input_is_left_click_or_touch(event):
				pressed.emit()
			)
	action_menu.baya.connect(_on_action_baya)
	action_menu.sura.connect(_on_action_sura)

func _process(delta):
	return
	if not fading:
		return
	if time_elapsed >= grayout_time:
		fading = false
		time_elapsed = 0
		return
	time_elapsed += delta
	var degree = lerpf(0, 1, time_elapsed / grayout_time)
	material.set_shader_parameter("degree", degree)

func show_options():
	if not enabled or showing_menu:
		return
	showing_menu = true
	action_menu.display()

func _on_action_baya():
	showing_menu = false
	action_menu.close()
	baya_chosen.emit()

func _on_action_sura():
	showing_menu = false
	action_menu.close()
	sura_chosen.emit()
