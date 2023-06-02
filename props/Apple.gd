extends Node2D

signal on_interact()


func _on_area_2d_on_interact():
	emit_signal("on_interact")
