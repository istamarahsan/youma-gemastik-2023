extends Control
class_name SettingsMenu

signal back

@onready var sfx_slider: HSlider = get_node("%SFXSlider")
@onready var music_slider: HSlider = get_node("%MusicSlider")
@onready var back_button: Button = get_node("%BackButton")

func _ready():
	sfx_slider.value = AudioManagerSingleton.sfx_scale
	music_slider.value = AudioManagerSingleton.music_scale
	AudioManagerSingleton.scale_changed.connect(func():
		sfx_slider.value = AudioManagerSingleton.sfx_scale
		music_slider.value = AudioManagerSingleton.music_scale
		)
	sfx_slider.value_changed.connect(func(_new):
		AudioManagerSingleton.sfx_scale = (sfx_slider.value / sfx_slider.max_value)
		)
	music_slider.value_changed.connect(func(_new): 
		AudioManagerSingleton.music_scale = (music_slider.value / music_slider.max_value)
		)
	back_button.button_up.connect(func(): back.emit())
