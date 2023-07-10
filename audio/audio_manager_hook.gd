extends AudioStreamPlayer

enum Channel {
	Sfx,
	Music
}

@export var channel: Channel = Channel.Sfx

func _ready():
	AudioManagerSingleton.scale_changed.connect(_on_scale_changed)

func _on_scale_changed():
	volume_db = lerpf(-60, 0, _get_scale())

func _get_scale() -> float:
	match channel:
		Channel.Sfx:
			return AudioManagerSingleton.sfx_scale
		_:
			return AudioManagerSingleton.music_scale
