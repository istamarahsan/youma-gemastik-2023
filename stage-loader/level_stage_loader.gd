extends StageLoader
class_name LevelStageLoader

@export var level_scene: PackedScene

func load_stage() -> Stage:
	var stage = level_scene.instantiate() as Stage
	return stage
