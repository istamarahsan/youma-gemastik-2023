extends Node2D
class_name TimeAttackSpawner

signal spawned(creature: Node2D)

const fish_scene: PackedScene = preload("res://levels/level-4/time_attack_fish.tscn")

@export var active: bool:
	get:
		return _active
	set(value):
		_active_set(value)
		_active = value
@export var facing: TimeAttackFish.Direction = TimeAttackFish.Direction.Left
@export_range(0, 1, 0.01) var speed: float = 0.5
@export_range(0.1, 10, 0.01) var spawn_interval_seconds: float = 3
@export_range(0, 5, 0.01) var max_interval_variation: float = 0.0
@export_range(0, 1, 0.01) var bait_chance: float = 0.3

@onready var timer: Timer = $Timer

var _active: bool = false

func _ready():
	if _active:
		_start_next_spawn()

func _active_set(will_be_active: bool):
	if timer == null:
		return
	if not timer.is_stopped():
		timer.stop()
	if not will_be_active:
		return
	_start_next_spawn()

func _on_timer_timeout():
	if not _active:
		return
	var is_bait = _roll_is_bait()
	var fish = fish_scene.instantiate()
	if is_bait:
		fish.set_bait()
	fish.set_speed_scale(speed)
	fish.set_direction(facing)
	spawned.emit(fish)
	_start_next_spawn()

func _roll_time_to_spawn() -> float:
	var base := spawn_interval_seconds
	var offset := lerpf(-max_interval_variation, max_interval_variation, randf()) if max_interval_variation > 0.0 else 0.0
	return base + offset

func _roll_is_bait() -> bool:
	var is_bait := randf() < bait_chance
	return is_bait
	
func _start_next_spawn():
	var time_to_spawn = _roll_time_to_spawn()
	timer.wait_time = time_to_spawn
	timer.start()
