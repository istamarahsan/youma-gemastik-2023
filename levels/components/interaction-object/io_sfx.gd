extends Node

@export var io: InteractionObject

@onready var click_sfx: AudioStreamPlayer = $Click as AudioStreamPlayer
@onready var confirm_sfx: AudioStreamPlayer = $Confirm as AudioStreamPlayer

func _ready():
	io.pressed.connect(_on_io_pressed)
	io.interacted.connect(_on_io_interact)
	
func _on_io_pressed():
	click_sfx.play()

func _on_io_interact():
	confirm_sfx.play()
