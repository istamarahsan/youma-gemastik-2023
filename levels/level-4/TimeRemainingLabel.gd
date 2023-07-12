extends Label

@export var timer: Timer

func _process(delta):
	text = str(ceil(timer.time_left))
