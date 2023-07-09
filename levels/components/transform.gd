extends Node2D
class_name Transform

signal activated

@export var trigger: Trigger

func _ready():
	if trigger != null:
		trigger.activated.connect(activate)

func activate():
	activated.emit()
