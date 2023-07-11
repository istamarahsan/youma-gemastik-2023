@tool
extends InteractionObject
class_name PhysicsAreaInteractionObject


@export_range(1, 300, 0.1) var radius: int: 
	set(value):
		var collision_shape = get_node_or_null("InteractionArea/AreaShape")
		if collision_shape != null and collision_shape is CollisionShape2D:
			collision_shape.shape.radius = value
		var io_highlight = get_node_or_null("IOHighlight")
		if io_highlight != null and io_highlight is Sprite2D:
			io_highlight.texture.width = value * 2
			io_highlight.texture.height = value * 2
	get:
		var collision_shape = get_node_or_null("InteractionArea/AreaShape")
		if collision_shape != null and collision_shape is CollisionShape2D:
			return collision_shape.shape.radius
		return 0

@onready var area_2d = $InteractionArea

func _ready():
	if area_2d == null:
		return
	area_2d.input_event.connect(
		func(viewport, event, shape): 
			if InputExtensions.input_is_left_click_or_touch(event):
				pressed.emit()
			)
	area_2d.input_pickable = enabled
	$IOHighlight.texture.width = radius * 2
	$IOHighlight.texture.height = radius * 2

func _set_enabled(yes: bool):
	if Engine.is_editor_hint():
		return
	area_2d.input_pickable = yes

func _show_interactions():
	if Engine.is_editor_hint():
		return
	interacted.emit()

func _on_state_entered(state):
	if state != InteractionObject.State.active:
		$IOHighlight.visible = false
		return
	$IOHighlight.visible = true
