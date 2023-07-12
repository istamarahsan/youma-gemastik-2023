extends Stage
class_name CutscenePresenter

var _flag: bool = false

func load_cutscene(data: Cutscene):
	pass

func _input(event):
	if not _flag and InputExtensions.input_is_left_click_or_touch(event):
		_flag = true
		completed.emit()
