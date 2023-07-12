extends Control
class_name SubtitleSlideshow

@onready var slide: TextureRect = $Slide as TextureRect
@onready var char_label: Label = $Character as Label
@onready var dialogue_label: Label = $Dialogue as Label
	
func reset():
	slide.texture = null
	char_label.text = ""
	dialogue_label.text = ""

func set_bg(bg: Texture2D):
	slide.texture = bg

func set_line(line: CutsceneLine):
	char_label.text = line.character
	dialogue_label.text = line.line
	
func to_line():
	pass
