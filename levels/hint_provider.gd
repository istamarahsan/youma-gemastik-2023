extends Trigger

@export_range(1, 10, 0.1) var grace_period_seconds: float
@export var map: Map

@onready var grace_period_timer: Timer = $Timer

func _ready():
	grace_period_timer.wait_time = grace_period_seconds
	grace_period_timer.one_shot = false
	grace_period_timer.stop()
	map.interaction_created.connect(func(_name, _value, _flag): _on_map_interaction_created())

func _on_map_interaction_created():
	grace_period_timer.stop()
	grace_period_timer.start()

func _on_timer_timeout():
	activated.emit()
