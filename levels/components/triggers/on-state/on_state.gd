extends Trigger
class_name TriggerOnState

@export_category("Constraints")
@export var values: Array[StateValueConstraint] = []
@export var flags: Array[StateFlagConstraint] = []
@export var oneshot: bool = true

var _has_triggered: bool = false

func _on_level_state_hook_state_updated(state: ReadOnlyLevelState):
	for constraint in values:
		if not constraint.satisfied_by(state):
			return
	for constraint in flags:
		if not constraint.satisfied_by(state):
			return
	if oneshot and _has_triggered:
		return
	activated.emit()
	_has_triggered = true
