extends Node

@onready
var raycast: RayCast2D = $RayCast2D

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		raycast.position = event.position
		raycast.force_raycast_update()
		var col = raycast.get_collider()
		if col is Interactable:
			col.interact()
