extends RayCast2D

signal bin_detected

var done: bool = false

func _physics_process(delta):
	if done:
		return
	if is_colliding():
		bin_detected.emit()
