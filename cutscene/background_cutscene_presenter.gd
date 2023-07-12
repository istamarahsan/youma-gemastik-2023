extends CutscenePresenter
class_name BackgroundCutscenePresenter

@export_range(0.1, 10, 0.1) var start_delay: float = 0.1
@export_range(0.1, 10, 0.1) var interval: float = 0.1
@export_range(0.1, 10, 0.1) var lifetime: float = 0.1
@export_range(0.1, 10, 0.1) var fade: float = 0.1

@onready var lifetime_timer: Timer = $Lifetime as Timer
@onready var interval_timer: Timer = $Interval as Timer
@onready var delay_timer: Timer = $Delay as Timer

@onready var slide: TextureRect = $Slide as TextureRect
@onready var char_label: Label = $Character as Label
@onready var dialogue_label: Label = $Dialogue as Label

var data: Cutscene

func load_cutscene(data: Cutscene):
	self.data = data

func _ready():
	if data == null:
		return
	_reset_display()
	slide.texture = data.bg

	delay_timer.one_shot = true
	delay_timer.wait_time = start_delay

	interval_timer.one_shot = true
	interval_timer.wait_time = interval
	
	lifetime_timer.one_shot = true
	lifetime_timer.wait_time = lifetime
	
	delay_timer.start()
	await delay_timer.timeout
	
	_begin()

func _begin():
	for line in data.lines:
		_set_line(line)
		
		var in_tween = get_tree().create_tween()
		await _tween_in_line(in_tween)
		
		lifetime_timer.start()
		await lifetime_timer.timeout
		
		var out_tween = get_tree().create_tween()
		await _tween_out_line(out_tween)

		interval_timer.start()
		await interval_timer.timeout
	completed.emit()

func _set_line(line: CutsceneLine):
	char_label.text = line.character
	dialogue_label.text = line.line

func _tween_in_line(in_tween: Tween):
	in_tween.tween_property(char_label, "modulate", Color(char_label.modulate.r, char_label.modulate.g, char_label.modulate.b, 1.0), fade)
	in_tween.tween_property(dialogue_label, "modulate", Color(dialogue_label.modulate.r, dialogue_label.modulate.g, dialogue_label.modulate.b, 1.0), fade)

func _tween_out_line(out_tween: Tween):
	out_tween.tween_property(char_label, "modulate", Color(char_label.modulate.r, char_label.modulate.g, char_label.modulate.b, 0.0), fade)
	out_tween.tween_property(dialogue_label, "modulate", Color(dialogue_label.modulate.r, dialogue_label.modulate.g, dialogue_label.modulate.b, 0.0), fade)

func _reset_display():
	slide.texture = null
	char_label.text = ""
	char_label.modulate.a = 0
	dialogue_label.text = ""
	dialogue_label.modulate.a = 0
