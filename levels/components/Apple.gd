extends Node2D

signal on_interact

func _on_area_2d_on_interact():
	emit_signal("on_interact")

func _on_control_gui_input(event):
	if event is InputEventMouseButton:
		if not event.is_pressed():
			on_interact.emit()
