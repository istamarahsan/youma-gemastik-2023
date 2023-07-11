extends Node

@export var io: InteractionObject

@onready var click_sfx: AudioStreamPlayer = $Click as AudioStreamPlayer
@onready var confirm_sfx: AudioStreamPlayer = $Confirm as AudioStreamPlayer
@onready var fail_sfx: AudioStreamPlayer = $Failed as AudioStreamPlayer

func _ready():
	if io == null:
		return
	io.interacted.connect(_on_io_interact)
	io.state_entered.connect(_on_io_state_entered)
	io.failed.connect(_on_io_failed)

func _on_io_state_entered(state: InteractionObject.State):
	match state:
		InteractionObject.State.active:
			_on_io_active()
		InteractionObject.State.showing:
			_on_io_showing()

func _on_io_active():
	click_sfx.play()

func _on_io_showing():
	click_sfx.play()

func _on_io_interact():
	confirm_sfx.play()

func _on_io_failed():
	fail_sfx.play()
