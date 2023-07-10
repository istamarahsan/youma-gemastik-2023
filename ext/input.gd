extends Node

func input_is_left_click_or_touch(event: InputEvent) -> bool:
	if not event.is_pressed():
		return false
	if event is InputEventMouseButton:
		return true if event.button_index == 1 else false
	if event is InputEventScreenTouch:
		return true
	return false
