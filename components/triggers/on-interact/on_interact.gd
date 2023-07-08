extends Trigger
class_name TriggerOnInteract

@export var io: InteractionObject

func _ready():
	io.interacted.connect(func(): activated.emit())
