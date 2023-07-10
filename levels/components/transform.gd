extends Node2D
class_name Transform

signal activated

@export var trigger: Trigger
@export_range(0, 10, 0.1) var delay_seconds: float = 0

func _ready():
	if trigger != null:
		trigger.activated.connect(activate)

func activate():
	if delay_seconds > 0:
		var timer = Timer.new()
		timer.one_shot = true
		timer.wait_time = delay_seconds
		add_child(timer)
		timer.start()
		await timer.timeout
		timer.queue_free()
	activated.emit()
