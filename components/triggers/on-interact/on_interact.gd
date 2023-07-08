extends Trigger
class_name TriggerOnInteract

@export var io: InteractionObject

func _ready():
	if io != null and target != null:
		io.interacted.connect(func(): target.activate())
