extends Node2D
class_name Game

enum State {
	LoadingStage,
	InStage
}

signal quit_to_main_menu

@export var stage_set: GameStageSet
@export var transition_cover: TransitionCover

var active_stage: Stage
var stage_num: int = 0
var state: State = State.LoadingStage

func _ready():
	_load_stage()
	state = State.InStage

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		quit_to_main_menu.emit()

func _on_stage_completed():
	_transition_and_load_next_stage()

func _on_stage_exited():
	quit_to_main_menu.emit()

func _transition_and_load_next_stage():
	stage_num += 1
	state = State.LoadingStage
	transition_cover.close()
	await transition_cover.done
	_load_stage()
	transition_cover.open()
	state = State.InStage

func _load_stage():
	if active_stage != null and is_instance_valid(active_stage):
		active_stage.queue_free()
	if stage_num >= stage_set.stages.size():
		quit_to_main_menu.emit()
		return
	var stage_scene = stage_set.stages[stage_num]
	active_stage = stage_scene.instantiate() as Stage
	add_child(active_stage)
	active_stage.exited.connect(_on_stage_exited)
	active_stage.completed.connect(_on_stage_completed)
