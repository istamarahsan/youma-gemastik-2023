extends Transform
class_name TransformFadeProp

enum Action {
	In,
	Out
}

@export var target: PropAutoFade
@export var fade: Action = Action.Out

func _on_activated():
	match fade:
		Action.In:
			target.fade_in()
		Action.Out:
			target.fade_out()
