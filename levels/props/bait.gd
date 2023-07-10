@tool
extends PropAutoFade
class_name BaitProp

@export var bob: bool = false

func _ready():
	if not bob:
		$SpriteBobEffect.max_offset = 0
