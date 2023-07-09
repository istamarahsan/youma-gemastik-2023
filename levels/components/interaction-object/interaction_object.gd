@tool
extends Polygon2D
class_name InteractionObject

enum State {
	idle = 0,
	active = 1,
	showing = 2
}

enum DebugOption {
	none,
	editor_only,
	full
}

signal pressed
signal interacted

@export_category("Effects")
@export var value_effects: Array[IoValueEffect] = []
@export var flag_effects: Array[IoFlagEffect] = []
@export var transition_to: String = ""
@export var require_sufficient: bool = true
@export_category("Constraints")
@export var value_constraints: Array[StateValueConstraint] = []
@export var flag_constraints: Array[StateFlagConstraint] = []
@export_category("Properties")
@export var wait_travel: bool = true
@export var enabled: bool = true
@export var oneshot: bool = true
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
var state: State = State.idle

func _ready():
	pass

func _process(delta):
	if Engine.is_editor_hint():
		queue_redraw()

func set_enabled(yes: bool):
	enabled = yes
	queue_redraw()

func show_idle():
	state = State.idle
#	$ShaderSprite.material.set_shader_parameter("state", state)
	queue_redraw()

func show_active():
	state = State.active
#	$ShaderSprite.material.set_shader_parameter("state", state)
	$Active.play()
	queue_redraw()

func show_interactions():
	state = State.showing
#	$ShaderSprite.material.set_shader_parameter("state", state)
	$Showing.play()
	queue_redraw()
	interacted.emit()
	if oneshot:
		set_enabled(false)

func _set_handler_radius(value: int):
	var vertices = PackedVector2Array([
		Vector2(1, 1), 
		Vector2(1, -1), 
		Vector2(-1, -1), 
		Vector2(-1, 1)
	].map(func(vec): return vec * value)
	)
	polygon = vertices
	
	var shader_sprite = get_node_or_null("ShaderSprite")
	if shader_sprite != null:
		shader_sprite.texture.width = value * 2
		shader_sprite.texture.height = value * 2
	
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
