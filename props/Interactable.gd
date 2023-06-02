extends CollisionObject2D
class_name Interactable

signal interacted()

func interact():
	emit_signal("interacted")
