extends Transform

@export var fish: FishWithAutoFadeTransform

func _on_activated():
	fish.fade_in()
