extends Label

@export var timer: Timer

func _process(delta):
	text = str(timer.time_left)
