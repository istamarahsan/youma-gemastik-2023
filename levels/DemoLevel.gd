extends Node2D

var rock_placed: bool = false
var fish_count := 0
var inventory := {}
@onready
var inventoryContainer: Container = $Control/MarginContainer/UI/InventoryItems
@onready
var fishCounterLabel: Label = $Control/MarginContainer/UI/HBoxContainer/FishCountValue

func _on_fish_interacted():
	if not rock_placed:
		return
	$Fish.queue_free()
	fish_count += 1
	fishCounterLabel.text = String.num(fish_count)

func _on_rock_interacted():
	print("h")
	if rock_placed:
		return
	inventory["rock"] = true
	_update_inventory()
	$Rock.position = $OutOfMap.position

func _on_rock_target_location_interacted():
	if not inventory.has("rock"):
		return
	inventory.erase("rock")
	_update_inventory()
	$Rock.position = $RockTargetLocation.position
	rock_placed = true

func _update_inventory():
	for child in inventoryContainer.get_children():
		child.queue_free()
	var item_names = inventory.keys()
	item_names.sort()
	for item_name in item_names:
		var label = Label.new()
		label.text = "- " + item_name
		inventoryContainer.add_child(label)
		
