extends Control
class_name PauseMenu

signal lanjut
signal quit

enum State {
	Main,
	Settings
}

@onready var mainPanel: Control = $PauseMenuButtons
@onready var settings: Control = $AudioSettings
@onready var backButton: Control = $BackButton

var state: State = State.Main

func _ready():
	settings.visible = false
	backButton.visible = false

func _unhandled_input(event):
	match state:
		State.Main:
			if event.is_action_pressed("ui_cancel"):
				lanjut.emit()

func _on_pause_menu_buttons_lanjut():
	match state:
		State.Main:
			lanjut.emit()

func _on_pause_menu_buttons_settings():
	match state:
		State.Main:
			settings.visible = true
			backButton.visible = true
			mainPanel.visible = false
			state = State.Settings

func _on_pause_menu_buttons_quit():
	quit.emit()

func _on_back_button_button_up():
	match state:
		State.Settings:
			settings.visible = false
			backButton.visible = false
			mainPanel.visible = true
			state = State.Main
