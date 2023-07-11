extends Control
class_name PauseMenuButtons

signal lanjut
signal settings
signal quit

func _on_continue_button_up():
	lanjut.emit()

func _on_settings_button_up():
	settings.emit()

func _on_quit_button_up():
	quit.emit()
