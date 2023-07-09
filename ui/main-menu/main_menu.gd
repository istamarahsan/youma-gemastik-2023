extends Control
class_name MainMenu

signal play
signal settings
signal credits
signal quit

@onready var play_button: Button = get_node("%PlayButton")
@onready var settings_button: Button = get_node("%SettingsButton")
@onready var credits_button: Button = get_node("%CreditsButton")
@onready var quit_button: Button = get_node("%QuitButton")

func _on_play_button_button_up():
	play.emit()

func _on_settings_button_button_up():
	settings.emit()

func _on_credits_button_button_up():
	credits.emit()

func _on_quit_button_button_up():
	quit.emit()
