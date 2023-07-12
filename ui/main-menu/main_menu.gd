extends Control
class_name MainMenu

signal play
signal quit

@onready var mainPanel: MainMenuButtons = $MainMenuButtons
@onready var settingsPanel: AudioSettingsPanel = $AudioSettings
@onready var backButton: TextureButton = $BackButton
@onready var credits: Control = $Credits

enum State {
	Main,
	Settings,
	Credits
}

const min_amp_down: float = 500.0
const max_amp_down: float = 2000.0

var state: State = State.Main

func _ready():
	settingsPanel.visible = false
	backButton.visible = false
	
	mainPanel.position.y = -mainPanel.size.y
	
	get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE).tween_property(mainPanel, "position", Vector2(mainPanel.position.x, 0), 2)

func _on_main_menu_button_play():
	match state:
		State.Main:
			play.emit()

func _on_main_menu_button_settings():
	match state:
		State.Main:
			settingsPanel.visible = true
			backButton.visible = true
			mainPanel.visible = false
			state = State.Settings

func _on_main_menu_button_credits():
	match state:
		State.Main:
			backButton.visible = true
			mainPanel.visible = false
			credits.visible = true
			state = State.Credits

func _on_main_menu_button_quit():
	quit.emit()

func _on_back_button_button_up():
	match state:
		State.Settings:
			settingsPanel.visible = false
			backButton.visible = false
			mainPanel.visible = true
			state = State.Main
		State.Credits:
			credits.visible = false
			backButton.visible = false
			mainPanel.visible = true
			state = State.Main
