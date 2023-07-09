extends StateConstraint
class_name StateValueConstraint

enum Type {
	Minimum,
	Maximum,
	Equal
}

@export var value: int = 0
@export var type: Type = Type.Minimum

func satisfied_by(state: ReadOnlyLevelState) -> bool:
	match type:
		Type.Minimum:
			return state.get_value(name) >= value
		Type.Maximum:
			return state.get_value(name) <= value
		Type.Equal:
			return state.get_value(name) == value
	return false
