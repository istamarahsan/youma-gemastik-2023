extends Resource
class_name StateConstraint

@export var name: String = ""

func satisfied_by(state: ReadOnlyLevelState) -> bool:
	return true
