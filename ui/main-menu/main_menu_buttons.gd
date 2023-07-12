extends Node
class_name MainMenuButtons

signal play
signal settings
signal credits
signal quit

func _on_play_button_up():
	play.emit()

func _on_settings_button_up():
	settings.emit()

func _on_credits_button_up():
	credits.emit()

func _on_quit_button_up():
	quit.emit()
