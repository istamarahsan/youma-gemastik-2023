extends Trigger
class_name CompositeTrigger

@export var triggers: Array[NodePath] = []
@export var oneshot: bool = false

var _triggers: Array # Trigger
var oneshot_flag: bool = false
var has_triggered: Array # bool

func _ready():
	_triggers = triggers.map(func(path): return get_node_or_null(path)).filter(func(node): return node is Trigger)
	has_triggered = _triggers.map(func(_trigger): return false)
	for i in range(_triggers.size()):
		_triggers[i].activated.connect(func():
			has_triggered[i] = true
			if has_triggered.all(func(flag): return flag == true):
				if oneshot and oneshot_flag:
					return
				activated.emit()
				oneshot_flag = true
			)
