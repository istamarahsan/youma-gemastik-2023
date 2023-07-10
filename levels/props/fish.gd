@tool
extends PropAutoFade
class_name FishProp

@export var flip: bool:
	set(value):
		var node = get_node_or_null(sprite) as Sprite2D
		if node != null:
			node.flip_h = value
	get:
		var node = get_node_or_null(sprite) as Sprite2D
		if node != null:
			return node.flip_h
		return false
