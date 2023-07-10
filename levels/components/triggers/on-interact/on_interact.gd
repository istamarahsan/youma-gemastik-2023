extends Trigger
class_name TriggerOnInteract

@export var io: InteractionObject

func _ready():
	if io != null:
		io.interacted.connect(func(): activated.emit())
