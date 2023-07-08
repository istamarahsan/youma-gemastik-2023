extends StateConstraint
class_name StateFlagConstraint

func satisfied_by(state: ReadOnlyLevelState) -> bool:
	return state.has_flag(name)
