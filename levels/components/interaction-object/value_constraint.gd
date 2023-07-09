extends Resource
class_name IoValueConstraint

enum Type {
	Minimum,
	Maximum,
	Equal
}

@export var name: String = ""
@export var value: int = 0
@export var type: Type = Type.Minimum
