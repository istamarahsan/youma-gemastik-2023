extends Control
class_name ScrollingTextScene

@export var data: NarrativeCutsceneData
@export var line_scene: PackedScene

@onready var title_label: Label = get_node("%TitleLabel")
@onready var lines_container: Container = get_node("%LinesContainer")
@onready var continue_button: Button = get_node("%ContinueButton")

func _ready():
	init()

func init():
	if data == null:
		return
	for child in lines_container.get_children():
		child.queue_free()
	title_label.text = data.title
	for line in data.lines:
		var paragraph_label: Label = line_scene.instantiate()
		paragraph_label.text = line.content
		lines_container.add_child(paragraph_label)
