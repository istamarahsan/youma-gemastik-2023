extends Transform
class_name TransformIoStateConstraint

@export var target_io: InteractionObject
@export_category("Constraints")
@export var values: Array[StateValueConstraint]
@export var flags: Array[StateFlagConstraint]

func _on_level_state_hook_state_updated(state: ReadOnlyLevelState):
	if _constraints_pass(state):
		target_io.set_enabled(true)
	else:
		target_io.set_enabled(false)

func _constraints_pass(state: ReadOnlyLevelState) -> bool:
	for value_constraint in values:
		if state.get_value(value_constraint.name) < value_constraint.minimum:
			return false
	for flag_constraint in flags:
		if not state.has_flag(flag_constraint.name):
			return false
	return true
