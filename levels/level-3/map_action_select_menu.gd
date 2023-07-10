extends Control
class_name MapActionSelectMenu

signal baya
signal sura

func _ready():
	visible = false

func display():
	visible = true

func close():
	visible = false

func _on_sura_button_up():
	if visible:
		sura.emit()

func _on_baya_button_up():
	if visible:
		baya.emit()
