extends StageLoader
class_name CutsceneStageLoader

enum CutsceneType {
	Blank,
	Background
}

const background_presenter_scene: PackedScene = preload("res://cutscene/background_cutscene_presenter.tscn")
const blank_presenter_scene: PackedScene = preload("res://cutscene/blank_cutscene_presenter.tscn")

@export var cutscene: Cutscene
@export var type: CutsceneType = CutsceneType.Blank

func load_stage() -> Stage:
	var presenter_scene = _get_presenter_scene(type)
	var presenter = presenter_scene.instantiate() as CutscenePresenter
	presenter.load_cutscene(cutscene)
	return presenter

func _get_presenter_scene(type: CutsceneType) -> PackedScene:
	match type:
		CutsceneType.Blank:
			return blank_presenter_scene
		CutsceneType.Background:
			return background_presenter_scene
	return null
