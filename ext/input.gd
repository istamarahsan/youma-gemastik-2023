extends Node

func input_is_left_click_or_touch(event: InputEvent) -> bool:
	if event is InputEventMouseButton:
		if not event.is_pressed():
			return false
		return true if event.button_index == 1 else false
	if event is InputEventScreenTouch:
		if event.is_pressed():
			return false
		return true
	return false
