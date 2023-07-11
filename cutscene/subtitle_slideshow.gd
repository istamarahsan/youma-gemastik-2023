extends Control
class_name SubtitleSlideshow

@onready var slide: TextureRect = $Slide as TextureRect
@onready var cover: TransitionCover = $TransitionCover as TransitionCover
@onready var char_label: Label = $Character as Label
@onready var dialogue_label: Label = $Dialogue as Label

var is_transitioning: bool = false

signal transitioned
	
func reset(line: DialogueCutsceneLine):
	_set_data(line)

func next(line: DialogueCutsceneLine):
	if is_transitioning:
		return
	is_transitioning = true
	cover.close()
	await cover.done
	_set_data(line)
	cover.open()
	await cover.done
	is_transitioning = false
	
func _set_data(line: DialogueCutsceneLine):
	slide.texture = line.slide
	char_label.text = line.character_name
	dialogue_label.text = line.line
