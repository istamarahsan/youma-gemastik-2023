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
		land.baya_chosen.connect(func():
			choices[land.name] = Choice.Baya
			land.enabled = false
			_validate_state()
			)
		land.sura_chosen.connect(func():
			choices[land.name] = Choice.Sura
			land.enabled = false 
			_validate_state()
			)

func _validate_state():
	for land_name in choices.keys():
		if choices[land_name] != answer_key.get(land_name, null):
			_no()
			_reset_state()
			return
	if answer_key.keys().all(func(key): return choices.has(key)):
		completion_announcer.completed.emit()

func _reset_state():
	choices = {}
	for step in steps:
		var land = get_node_or_null(step.land) as SpecialMapInterationObject
		land.enabled = true
	
func _no():
	no.visible = true
	no_timer.start()

func _on_no_timer_timeout():
	no.visible = false
