extends Node2D
class_name TimeAttackFish

enum Direction{
	Left,
	Right
}

@export var max_speed: float = 100
@export_range(0, 1, 0.01) var speed_scale: float = 0.5
@export var direction: Direction
@export var velocity: Vector2:
	get:
		match direction:
			Direction.Left:
				return Vector2.LEFT * max_speed * speed_scale
			_:
				return Vector2.RIGHT * max_speed * speed_scale
@export var sprite: Sprite2D
@export var io: InteractionObject

func _ready():
	io.name = name
	
func _process(delta):
	sprite.flip_h = velocity.normalized().dot(Vector2.LEFT) < 0
	position += velocity * delta

func set_direction(direction: Direction):
	self.direction = direction

func set_speed_scale(speed: float):
	speed_scale = clampf(speed, 0, 1)

func set_bait():
	var eff = IoValueEffect.new()
	eff.name = "bait"
	eff.effect = 1
	io.value_effects.clear()
	io.value_effects = [eff]

func _on_ray_cast_2d_bin_detected():
	visible = false
	queue_free()
