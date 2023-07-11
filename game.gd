extends Node2D
class_name Game

enum State {
	LoadingStage,
	InStage,
	Paused,
	Pausing
}

signal quit_to_main_menu

const pause_menu_scene: PackedScene = preload("res://ui/pause-menu/pause_menu.tscn")

@export var stage_set: GameStageSet
@export var stage_transition_cover: TransitionCover
@export var pause_transition_cover: TransitionCover

var active_stage: Stage
var stage_num: int = 0
var state: State = State.LoadingStage

func _ready():
	_load_stage()
	state = State.InStage

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_to_pause_menu()

func _on_stage_completed():
	_transition_and_load_next_stage()

func _on_stage_exited():
	quit_to_main_menu.emit()

func _transition_and_load_next_stage():
	state = State.LoadingStage
	stage_num += 1
	stage_transition_cover.close()
	await stage_transition_cover.done
	_load_stage()
	stage_transition_cover.open()
	state = State.InStage

func _load_stage():
	if active_stage != null and is_instance_valid(active_stage):
		active_stage.queue_free()
	if stage_num >= stage_set.stages.size():
		_on_levels_completed()
		return
	var stage_scene = stage_set.stages[stage_num]
	active_stage = stage_scene.instantiate() as Stage
	add_child(active_stage)
	active_stage.exited.connect(_on_stage_exited)
	active_stage.completed.connect(_on_stage_completed)

func _to_pause_menu():
	if state != State.InStage:
		return
	state = State.Pausing
	pause_transition_cover.close()
	await pause_transition_cover.done
	if active_stage != null:
		active_stage.visible = false
	var pause_menu = pause_menu_scene.instantiate() as PauseMenu
	_hook_up_pause_menu(pause_menu)
	add_child(pause_menu)
	pause_transition_cover.open()
	await pause_transition_cover.done
	state = State.Paused
	
func _hook_up_pause_menu(menu: PauseMenu):
	menu.lanjut.connect(func(): _on_pause_menu_lanjut(menu))
	menu.quit.connect(func(): _on_pause_menu_quit(menu))

func _on_pause_menu_lanjut(menu: PauseMenu):
	if state != State.Paused:
		return
	state = State.Pausing
	pause_transition_cover.close()
	await pause_transition_cover.done
	menu.visible = false
	active_stage.visible = true
	pause_transition_cover.open()
	await pause_transition_cover.done
	menu.queue_free()
	state = State.InStage

func _on_pause_menu_quit(menu: PauseMenu):
	if state != State.Paused:
		return
	quit_to_main_menu.emit()

func _on_levels_completed():
	quit_to_main_menu.emit()
