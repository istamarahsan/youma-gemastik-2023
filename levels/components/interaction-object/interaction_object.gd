@tool
extends Node2D
class_name InteractionObject

enum State {
	idle = 0,
	active = 1,
	showing = 2
}

signal pressed
signal interacted
signal state_entered(state: State)

@export_category("Effects")
@export var value_effects: Array[IoValueEffect] = []
@export var flag_effects: Array[IoFlagEffect] = []
@export var transition_to: String = ""
@export var require_sufficient: bool = true
@export_category("Constraints")
@export var value_constraints: Array[StateValueConstraint] = []
@export var flag_constraints: Array[StateFlagConstraint] = []
@export_category("Properties")
@export var wait_travel: bool = true
@export var enabled: bool = true
@export var oneshot: bool = true

var state: State = State.idle

func set_enabled(yes: bool):
	enabled = true
	_set_enabled(yes)

func show_idle():
	state = State.idle
	_show_idle()
	state_entered.emit(State.idle)

func show_active():
	state = State.active
	_show_active()
	state_entered.emit(State.active)

func show_interactions():
	state = State.showing
	if oneshot:
		set_enabled(false)
	_show_interactions()
	state_entered.emit(State.showing)

func _set_enabled(yes: bool):
	pass

func _show_idle():
	pass

func _show_active():
	pass

func _show_interactions():
	pass
