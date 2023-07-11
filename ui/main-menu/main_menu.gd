extends Control
class_name MainMenu

signal play
signal settings
signal credits
signal quit

func _on_main_menu_button_play():
	play.emit()

func _on_main_menu_button_settings():
	settings.emit()

func _on_main_menu_button_credits():
	credits.emit()

func _on_main_menu_button_quit():
	quit.emit()
