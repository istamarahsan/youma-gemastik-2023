extends Control
class_name PauseMenu

signal lanjut
signal quit

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		lanjut.emit()

func _on_pause_menu_buttons_lanjut():
	lanjut.emit()

func _on_pause_menu_buttons_settings():
	pass # Replace with function body.

func _on_pause_menu_buttons_quit():
	quit.emit()
