#extends Level
#
#enum Level1Map {
#	Seashore,
#	ShallowWater
#}
#
#class SeashorePuzzleState extends RefCounted:
#	var io1_activated := false
#	var io2_activated := false
#	var io3_activated := false
#	var io4_activated := false
#	var io5_activated := false
#
#class ShallowWaterPuzzleState extends RefCounted:
#	var io1_activated := false
#	var io2_activated := false
#	var io3_activated_stone_close := false
#	var io4_activated := false
#
#@export var seashore_map: Map
#@export var shallow_water_map: Map
#
#var food: int
#var bait: int
#var stone: int
#var current_map: Level1Map
#
#var seashore_puzzle_state: SeashorePuzzleState = SeashorePuzzleState.new()
#var shallow_water_puzzle_state: ShallowWaterPuzzleState = ShallowWaterPuzzleState.new()
#
#func _ready():
#	food = 0
#	bait = 0
#	stone = 0
#	current_map = Level1Map.Seashore
#	seashore_map.visible = true
#	shallow_water_map.visible = false
#	shallow_water_map.position = offstage_marker.position
#
#	seashore_map.interaction_created.connect(func(interaction_name): _handle_interaction(Level1Map.Seashore, interaction_name))
#	shallow_water_map.interaction_created.connect(func(interaction_name): _handle_interaction(Level1Map.ShallowWater, interaction_name))
#
#func _handle_interaction(map: Level1Map, interaction_name: String):
#	match map:
#		Level1Map.Seashore:
#			_handle_seashore_interaction(interaction_name)
#		Level1Map.ShallowWater:
#			_handle_shallow_water_interaction(interaction_name)
#
#func _handle_seashore_interaction(interaction_name: String):
#	match interaction_name:
#		"IO1":
#			if seashore_puzzle_state.io1_activated:
#				return
#			seashore_puzzle_state.io1_activated = true
#			food += 1
#			seashore_map.transform("T1")
#		"IO2":
#			seashore_puzzle_state.io2_activated = true
#			seashore_map.transform("T2")
#		"IO3":
#			if not seashore_puzzle_state.io2_activated:
#				return
#			_add_food(1)
#			_add_bait(1)
#		"IO4":
#			if bait < 1:
#				return
#			seashore_puzzle_state.io4_activated = true
#			seashore_map.transform("T3")
#		"IO5":
#			if not seashore_puzzle_state.io4_activated:
#				return
#			_add_food(1)
#		"IO6":
#			print(1)
#			_transition_map(Level1Map.ShallowWater)
#
#func _handle_shallow_water_interaction(interaction_name: String):
#	match interaction_name:
#		"IO1":
#			if shallow_water_puzzle_state.io1_activated:
#				return
#			shallow_water_puzzle_state.io1_activated = true
#			shallow_water_map.transform("T1")
#			_add_food(1)
#		"IO2":
#			if shallow_water_puzzle_state.io2_activated:
#				return
#
#func _transition_map(to: Level1Map):
#	if to == current_map:
#		return
#	match to:
#		Level1Map.Seashore:
#			_move_offstage(shallow_water_map)
#			_move_onstage(seashore_map)
#		Level1Map.ShallowWater:
#			_move_offstage(seashore_map)
#			_move_onstage(shallow_water_map)
#	current_map = to
#
#func _add_food(amount: int):
#	food += amount
#	if food >= 3:
#		seashore_map.transform("T4")
#
#func _add_bait(amount: int):
#	bait += amount
#
#func _add_stone(amount: int):
#	stone += amount
#	if stone >= 1:
#		shallow_water_map.transform("3")
