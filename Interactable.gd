extends CollisionObject2D
class_name Interactable

signal on_interact()

func interact():
	emit_signal("on_interact")
