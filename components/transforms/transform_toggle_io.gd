extends Transform
class_name TransformToggleIo

enum Action {
	Enable,
	Disable,
	Toggle
}

@export var target_io: InteractionObject
@export var action: Action = Action.Enable

func _on_activated():
	match action:
		Action.Enable:
			target_io.set_enabled(true)
		Action.Disable:
			target_io.set_enabled(false)
		Action.Toggle:
			target_io.set_enabled(!target_io.enabled)
