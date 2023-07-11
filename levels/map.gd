extends Node2D
class_name Map

signal interaction_created(interaction: String, value_effects: Array[IoValueEffect], flag_effects: Array[IoFlagEffect])
signal transition_requested(to: String)
signal map_clicked(position: Vector2)
signal complete

@export var player_avatar: PlayerAvatar
@export var state_hook: LevelStateHook

var active_interaction_object_name: String
var interaction_objects_by_name: Dictionary = {}
var traveling: bool = false

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			map_clicked.emit(event.position)

func _ready():
	var tree = TreeExtensions.get_tree_rec(self)
	for node in tree:
		if node is InteractionObject:
			var io = node as InteractionObject
			_register_io(io)
	state_hook.state_updated_delta.connect(
		func(_state, val_delta, _flag_delta):
			if val_delta.has("bait"):
				print_debug(name)
				var bait_delta: int = val_delta["bait"]
				var gained: bool = bait_delta > 0
				if gained:
					player_avatar.show_bait()
			)

func _on_click(name: String):
	if traveling:
		return
	if active_interaction_object_name == name:
		var object = interaction_objects_by_name[active_interaction_object_name] as InteractionObject
		for constraint in object.value_constraints:
			if not constraint.satisfied_by(state_hook.get_state()):
				object.show_failed_then_return_idle()
				return
		for constraint in object.flag_constraints:
			if not constraint.satisfied_by(state_hook.get_state()):
				object.show_failed_then_return_idle()
				return
		for negative_effect in object.value_effects.filter(func(effect): return effect.effect < 0):
			if state_hook.get_state().get_value(negative_effect.name) < negative_effect.effect:
				object.show_failed_then_return_idle()
				return
		traveling = true
		if object.wait_travel:
			if object.is_moving_target:
				player_avatar.follow_target(object)
			else:
				player_avatar.travel_to(object.global_position)
			await player_avatar.arrived
		object.show_interactions()
		traveling = false
		return
	if active_interaction_object_name != null and interaction_objects_by_name.has(active_interaction_object_name):
		interaction_objects_by_name[active_interaction_object_name].show_idle()
	active_interaction_object_name = name
	interaction_objects_by_name[active_interaction_object_name].show_active()

func _on_interaction(name: String, value_effects: Array[IoValueEffect], flag_effects: Array[IoFlagEffect], transition_to: String):
	interaction_created.emit(name, value_effects, flag_effects)
	if transition_to != "":
		transition_requested.emit(transition_to)

func _register_io(io: InteractionObject):
	interaction_objects_by_name[io.name] = io
	io.pressed.connect(func(): _on_click(io.name))
	io.interacted.connect(
		func(): 
			_on_interaction(
				io.name, 
				io.value_effects, 
				io.flag_effects,
				io.transition_to
			)
	)
