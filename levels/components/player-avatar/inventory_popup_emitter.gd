extends CPUParticles2D
class_name InventoryPopupEmitter

@export var bait: Texture2D

@onready var label: Label = $wdymicantdoitwithparticles

func show_bait():
	if not is_visible_in_tree():
		return
	texture = bait
	one_shot = true
	restart()

func show_count(quantity: int):
	label.position = Vector2(-100, 0)
	label.modulate = "white"
	label.text = str(quantity)
	label.modulate.a = 1.0
	label.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position", Vector2(-100, -50), 0.5)
	tween.tween_property(label, "modulate", Color(label.modulate.r, label.modulate.g, label.modulate.b, 0.0), 1)
	tween.tween_callback(func(): label.visible = false)
	
