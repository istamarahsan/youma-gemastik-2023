extends Resource
class_name IoFlagEffect

enum FlagAction {
	Enable,
	Disable,
	Toggle
}

@export var name: String = ""
@export var action: FlagAction = FlagAction.Enable
