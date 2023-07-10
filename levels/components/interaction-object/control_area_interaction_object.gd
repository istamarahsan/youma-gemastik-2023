@tool
extends InteractionObject
class_name ControlAreaInteractionObject

@export_range(1, 1000, 1) var size: int:
	get:
		return _radius
	set(value):
		_radius = value
		_set_handler_radius(value)
		queue_redraw()
@export_category("Debug")
@export var debug: DebugOption = DebugOption.editor_only
@export_color_no_alpha var debug_color: Color = "#d9d9d9"

var _radius: int = 25

func _process(delta):
	if Engine.is_editor_hint():
		queue_redraw()

func _set_enabled(yes: bool):
	queue_redraw()

func _show_idle():
	queue_redraw()

func _show_active():
	queue_redraw()

func _show_interactions():
	$Showing.play()
	queue_redraw()
	interacted.emit()

func _set_handler_radius(value: int):
	var area = get_node_or_null("Area")
	if area != null:
		var vertices = PackedVector2Array([
			Vector2(1, 1), 
			Vector2(1, -1), 
			Vector2(-1, -1), 
			Vector2(-1, 1)
		].map(func(vec): return vec * value)
		)
		area.polygon = vertices
	
	var input_handler = get_node_or_null("InputHandler")
	if input_handler != null:
		input_handler.size = Vector2(value*2, value*2)
		input_handler.position = Vector2(-value, -value)
		queue_redraw()

func _on_input_handler_gui_input(event):
	if not enabled:
		return
	if event is InputEventMouseButton:
		if event.is_pressed():
			pressed.emit()

func _draw():
	if debug != DebugOption.none:
		if debug == DebugOption.editor_only and Engine.is_editor_hint():
			draw_circle(position / position.length_squared() if position != Vector2.ZERO else Vector2.ZERO, _radius, Color(debug_color, 0.4))
		elif debug == DebugOption.full:
			if state == State.showing:
				draw_circle(position / position.length_squared() if position != Vector2.ZERO else Vector2.ZERO, _radius, Color(debug_color, 1))
			elif state == State.active:
				draw_circle(position / position.length_squared() if position != Vector2.ZERO else Vector2.ZERO, _radius, Color(debug_color, 0.8))
			else:
				draw_circle(position / position.length_squared() if position != Vector2.ZERO else Vector2.ZERO, _radius, Color(debug_color, 0.2))
