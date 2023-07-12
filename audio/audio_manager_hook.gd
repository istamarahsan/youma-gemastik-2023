extends AudioStreamPlayer

enum Channel {
	Sfx,
	Music
}

@export var channel: Channel = Channel.Sfx

func _ready():
	AudioManagerSingleton.scale_changed.connect(_adjust_scale)
	_adjust_scale()

func _adjust_scale():
	volume_db = lerpf(-60.0, 0.0, AudioManagerSingleton.master_scale * _get_scale())

func _get_scale() -> float:
	match channel:
		Channel.Sfx:
			return AudioManagerSingleton.sfx_scale
		_:
			return AudioManagerSingleton.music_scale
