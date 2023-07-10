extends Node
class_name CompletionAnnouncer

signal completed

@export var trigger: Trigger

func _ready():
	if trigger != null:
		trigger.activated.connect(func(): completed.emit())
