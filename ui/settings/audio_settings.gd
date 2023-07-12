extends Control
class_name AudioSettingsPanel

@export var master_slider: HSlider
@export var sfx_slider: HSlider
@export var music_slider: HSlider

func _ready():
	master_slider.value = AudioManagerSingleton.master_scale
	sfx_slider.value = AudioManagerSingleton.sfx_scale
	music_slider.value = AudioManagerSingleton.music_scale
	AudioManagerSingleton.scale_changed.connect(func():
		master_slider.value = AudioManagerSingleton.master_scale
		sfx_slider.value = AudioManagerSingleton.sfx_scale
		music_slider.value = AudioManagerSingleton.music_scale
		)
	master_slider.value_changed.connect(func(_new):
		AudioManagerSingleton.master_scale = (master_slider.value / master_slider.max_value))
	sfx_slider.value_changed.connect(func(_new):
		AudioManagerSingleton.sfx_scale = (sfx_slider.value / sfx_slider.max_value)
		)
	music_slider.value_changed.connect(func(_new): 
		AudioManagerSingleton.music_scale = (music_slider.value / music_slider.max_value)
		)
