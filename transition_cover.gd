extends Node2D
class_name TransitionCover

enum State {
	Idle,
	Opening,
	Closing
}

signal done

@export_range(0.5, 10, 0.1) var time_seconds: float
var time_elapsed: float = 0
var state: State = State.Idle

func _process(delta):
	if state == State.Idle:
		time_elapsed = 0
	if state == State.Opening or state == State.Closing:
		if time_elapsed >= time_seconds:
			state = State.Idle
			time_elapsed = 0
			done.emit()
			return
		material.set_shader_parameter(
			"opacity", 
			lerpf(
				0 if state == State.Closing else 1, 
				1 if state == State.Closing else 0, 
				time_elapsed/time_seconds)
		)
		time_elapsed += delta

func close():
	if state != State.Idle:
		return
	state = State.Closing

func open():
	if state != State.Idle:
		return
	state = State.Opening
