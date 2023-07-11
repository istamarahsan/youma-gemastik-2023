extends Node
class_name LevelStateHook

var _state: LevelState

signal state_updated(state: ReadOnlyLevelState)
signal state_updated_delta(
	state: ReadOnlyLevelState, 
	value_delta: Dictionary,
	flag_delta: Array[String] # not implemented 
	)

func get_state() -> ReadOnlyLevelState:
	return _state as ReadOnlyLevelState
