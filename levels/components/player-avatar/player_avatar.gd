extends Node2D
class_name PlayerAvatar

signal arrived

@export_range(100, 500, 1) var speed: float = 500
@export var sprite: Sprite2D
@export var nav: NavigationAgent2D
@export var inventory_emitter: InventoryPopupEmitter

var target: Node2D = null

func _ready():
	nav.navigation_finished.connect(_on_navigation_agent_2d_navigation_finished)

func _physics_process(delta):
	if target != null:
		travel_to(target.global_position)

func show_bait():
	inventory_emitter.show_bait()

func can_navigate_to(destination: Vector2) -> bool:
	var prev = nav.target_position
	nav.target_position = destination
	var reachable = nav.is_target_reachable()
	if not reachable:
		nav.target_position = prev
	return reachable

func travel_to(destination: Vector2):
	nav.target_position = destination

func follow_target(target: Node2D):
	self.target = target

func _process(delta):
	if nav.is_navigation_finished():
		return
	var targetPathNode: Vector2 = nav.get_next_path_position()
	var direction = (targetPathNode - global_position).normalized()
	var velocity = direction * speed
	
	position += velocity * delta
	sprite.flip_h = direction.dot(Vector2.LEFT) < 0

func _on_navigation_agent_2d_navigation_finished():
	target = null
	arrived.emit()