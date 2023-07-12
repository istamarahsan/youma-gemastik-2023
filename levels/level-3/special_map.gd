extends Map
class_name SpecialMap

enum Choice {
	Sura,
	Baya
}

@export var completion_announcer: CompletionAnnouncer
@export var steps: Array[SpecialMapStep] = []

@onready var no: Label = $NO
@onready var no_timer: Timer = $NOTimer
@onready var select_sfx: AudioStreamPlayer = $Select
@onready var reset_sfx: AudioStreamPlayer = $Reset
@onready var finalize_sfx: AudioStreamPlayer = $Finalize

var answer_key: Dictionary = {}
var choices: Dictionary = {}

func _ready():
	super._ready()
	no.visible = false
	for step in steps:
		var land = get_node_or_null(step.land) as SpecialMapInterationObject
		if land == null:
			continue
		answer_key[land.name] = step.correct_choice
		land.pressed.connect(func():
			if land.enabled:
				select_sfx.play()
				land.show_options()
			)
		land.baya_chosen.connect(func():
			_handle_action(land, Choice.Baya)
			)
		land.sura_chosen.connect(func():
			_handle_action(land, Choice.Sura)
			)

func _handle_action(land: SpecialMapInterationObject, action: Choice):
	choices[land.name] = action
	if _is_state_valid():
		land.enabled = false
		finalize_sfx.play()
		if _is_map_complete():
			completion_announcer.completed.emit()
	else:
		_no()
		_reset_state()

func _is_state_valid() -> bool:
	for land_name in choices.keys():
		if choices.get(land_name, null) != null and choices[land_name] != answer_key.get(land_name, null):
			return false
	return true

func _is_map_complete() -> bool:
	return _is_state_valid() and answer_key.keys().all(func(key): return choices.has(key))

func _reset_state():
	choices = {}
	for step in steps:
		var land = get_node_or_null(step.land) as SpecialMapInterationObject
		land.enabled = true
	reset_sfx.play()
	
func _no():
	no.visible = true
	no_timer.start()

func _on_no_timer_timeout():
	no.visible = false
