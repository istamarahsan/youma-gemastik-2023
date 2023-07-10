extends Map

var spawners: Dictionary = {}

func _ready():
	super._ready()
	for node in get_children():
		if node is TimeAttackSpawner:
			spawners[node.name] = node
			node.spawned.connect(
				func(creature):
					add_child(creature)
					creature.position = spawners[node.name].position
					_register_io(creature.io)
					)
