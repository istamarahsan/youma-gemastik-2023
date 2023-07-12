extends Label

@export_range(0, 1, 0.01) var max_opacity: float = 0.8
@export_range(0.1, 10, 0.1) var interval: float = 0.5
@export_range(0.1, 10, 0.1) var lifetime: float = 0.5
@export_range(0.1, 2, 0.01) var fade: float = 0.25
@export_range(0, 10, 0.01) var start_delay: float = 0
@export_multiline var lines: Array[String] = []

@onready var delay_timer: Timer = $DelayTimer
@onready var interval_timer: Timer = $IntervalTimer
@onready var lifetime_timer: Timer = $LifetimeTimer

var counter: int = 0

func _ready():
	modulate.a = 0
	interval_timer.wait_time = interval
	interval_timer.one_shot = true
	lifetime_timer.wait_time = lifetime
	lifetime_timer.one_shot = true
	if start_delay > 0:
		delay_timer.wait_time = start_delay
		delay_timer.one_shot = true
		delay_timer.timeout.connect(_begin)
		delay_timer.start()
		await delay_timer.timeout
	else:
		_begin()

func _begin():
	for line in lines:
		text = line
		var in_tween = get_tree().create_tween()
		in_tween.tween_property(self, "modulate", Color(modulate.r, modulate.g, modulate.b, max_opacity), fade)
		await in_tween.finished
		lifetime_timer.start()
		await lifetime_timer.timeout
		var out_tween = get_tree().create_tween()
		out_tween.tween_property(self, "modulate", Color(modulate.r, modulate.g, modulate.b, 0.0), fade)
		await out_tween.finished
		interval_timer.start()
		await interval_timer.timeout
