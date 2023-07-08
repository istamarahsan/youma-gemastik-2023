extends ReadOnlyLevelState
class_name LevelState

func set_value(name: String, value: int):
	_values[name] = value
	
func set_flag(name: String):
	if name not in _flags:
		_flags.append(name)

func remove_flag(name: String):
	_flags = _flags.filter(func(x): return x != name)
