extends Node
class_name LevelStateHook

var _state: LevelState

signal state_updated(state: ReadOnlyLevelState)

func get_state() -> ReadOnlyLevelState:
	return _state as ReadOnlyLevelState
