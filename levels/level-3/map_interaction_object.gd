extends Node2D
class_name SpecialMapInterationObject

@export var area2D: Area2D
@export var action_menu: MapActionSelectMenu

var showing_menu: bool = false
var enabled: bool = true

signal sura_chosen
signal baya_chosen

func _unhandled_input(event):
	if InputExtensions.input_is_left_click_or_touch(event):
		showing_menu = false
		action_menu.hide()

func _ready():
	if area2D == null or action_menu == null:
		return
	area2D.input_event.connect(
		func(_viewport, event, _shape): 
			if InputExtensions.input_is_left_click_or_touch(event):
				_on_input()
			)
	action_menu.baya.connect(_on_action_baya)
	action_menu.sura.connect(_on_action_sura)
	
func _on_input():
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
