extends Node
class_name ReadOnlyLevelState

@export var _values: Dictionary = {}
@export var _flags: Array[String] = []

func get_value(name: String) -> int:
	return _values.get(name, 0)
	
func has_flag(name: String) -> bool:
	return name in _flags
