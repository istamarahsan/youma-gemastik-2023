extends CPUParticles2D
class_name InventoryPopupEmitter

@export var bait: Texture2D

func show_bait():
	if not is_visible_in_tree():
		return
	texture = bait
	one_shot = true
	restart()
