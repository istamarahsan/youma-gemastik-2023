extends Control
class_name LevelSelect

signal start

@onready var surabaya_label: Label = $Label

func _on_button_button_up():
	start.emit()
