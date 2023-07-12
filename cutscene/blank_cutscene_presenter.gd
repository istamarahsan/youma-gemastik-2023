extends CutscenePresenter
class_name BlankCutscenePresenter

var data: Cutscene

@export_range(0.1, 10, 0.1) var start_delay: float = 0.1
@export_range(0.1, 10, 0.1) var interval: float = 0.1
@export_range(0.1, 10, 0.1) var lifetime: float = 0.1
@export_range(0.1, 10, 0.1) var fade: float = 0.1

@onready var lifetime_timer: Timer = $Lifetime as Timer
@onready var interval_timer: Timer = $Interval as Timer
@onready var delay_timer: Timer = $Delay as Timer

@onready var label: Label = get_node("%BlankPresenterText")

func load_cutscene(data: Cutscene):
	self.data = data
	
func _ready():
	if data == null:
		return
		
	label.modulate.a = 0

	delay_timer.one_shot = true
	delay_timer.wait_time = start_delay

	interval_timer.one_shot = true
	interval_timer.wait_time = interval
	
	lifetime_timer.one_shot = true
	lifetime_timer.wait_time = lifetime
	
	delay_timer.start()
	await delay_timer.timeout
	
	for line in data.lines:
		label.text = line.line
		
		var in_tween = get_tree().create_tween()
		await _tween_in_line(in_tween)
		
		lifetime_timer.start()
		await lifetime_timer.timeout
		
		var out_tween = get_tree().create_tween()
		await _tween_out_line(out_tween)

		interval_timer.start()
		await interval_timer.timeout
		
	completed.emit()

func _tween_in_line(in_tween: Tween):
	in_tween.tween_property(label, "modulate", Color(label.modulate.r, label.modulate.g, label.modulate.b, 1.0), fade)

func _tween_out_line(out_tween: Tween):
	out_tween.tween_property(label, "modulate", Color(label.modulate.r, label.modulate.g, label.modulate.b, 0.0), fade)
