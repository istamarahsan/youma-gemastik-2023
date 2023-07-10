extends Stage
class_name Level

@export var offstage_marker: Node2D
@export var state: LevelState
@export var start: Map

var current_map_name: String = ""
var maps: Dictionary = {}
var state_hooks: Array[LevelStateHook] = []

func _ready():
	current_map_name = start.name
	maps[current_map_name] = start
	for child in get_children():
		if child is Map:
			maps[child.name] = child
			child.interaction_created.connect(
				func(
					interaction_name, 
					value_effects, 
					flag_effects
				): _on_map_interaction_created(
					child.name, 
					interaction_name, 
					value_effects, 
					flag_effects
				)
			)
			child.transition_requested.connect(
				func(target): _on_transition_requested(target)
			)
	for node in TreeExtensions.get_tree_rec(self):
		if node is LevelStateHook:
			node._state = state
			state_hooks.append(node)
		if node is CompletionAnnouncer:
			node.completed.connect(_on_map_completion_announced)

func _move_offstage(item: Node2D):
	item.position = offstage_marker.position
	item.visible = false

func _move_onstage(item: Node2D):
	item.position = Vector2(0, 0)
	item.visible = true

func _on_map_completion_announced():
	completed.emit()

func _on_map_interaction_created(map_name: String, interaction_name: String, values: Array[IoValueEffect], flags: Array[IoFlagEffect]):
	for effect in values:
		state.set_value(effect.name, state.get_value(effect.name) + effect.effect)
	for effect in flags:
		match effect.action:
			IoFlagEffect.FlagAction.Enable:
				state.set_flag(effect.name)
			IoFlagEffect.FlagAction.Disable:
				state.remove_flag(effect.name)
			IoFlagEffect.FlagAction.Toggle:
				if state.has_flag(effect.name):
					state.remove_flag(effect.name)
				else:
					state.set_flag(effect.name)
	for hook in state_hooks:
		hook.state_updated.emit(state as ReadOnlyLevelState)
	print_debug(state._values)
	print_debug(state._flags)

func _on_transition_requested(target_name: String):
	if target_name == current_map_name:
		return
	var target = maps.get(target_name, null)
	if target == null:
		return
	_move_offstage(maps.get(current_map_name))
	_move_onstage(target)
	current_map_name = target_name
