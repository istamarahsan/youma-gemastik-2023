extends Stage
class_name DialogueCutscenePresenter

@export var lines: Array[DialogueCutsceneLine] = []
@onready var slideshow: SubtitleSlideshow = $SubtitleSlideshow as SubtitleSlideshow

var next_line: int = 1

func _ready():
	if lines.size() < 1:
		return
	slideshow.reset(lines[0])

func _input(event):
	if slideshow.is_transitioning:
		return
	if InputExtensions.input_is_left_click_or_touch(event):
		_process_next()

func _process_next():
	if next_line >= lines.size():
		completed.emit()
		return
	slideshow.next(lines[next_line])
	next_line += 1
