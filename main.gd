extends Node2D

enum UpperState {
	MainMenu,
	Game,
	Credits,
	Settings
}

@export var main_menu_scene: PackedScene
@export var game_scene: PackedScene
@export var transition_cover: TransitionCover

var main_menu: MainMenu
var game: Game
var state: UpperState

func _ready():
	main_menu = main_menu_scene.instantiate() as MainMenu
	_hook_up_main_menu(main_menu)
	add_child(main_menu)
	state = UpperState.MainMenu

func _hook_up_main_menu(node: MainMenu):
	node.play.connect(_on_main_menu_play)
	node.settings.connect(_on_main_menu_settings)
	node.credits.connect(_on_main_menu_credits)
	node.quit.connect(_on_main_menu_quit)

func _hook_up_game(node: Game):
	node.quit_to_main_menu.connect(_on_game_quit_to_main_menu)

func _on_main_menu_play():
	if state != UpperState.MainMenu:
		return
	state = UpperState.Game
	transition_cover.close()
	await transition_cover.done
	main_menu.queue_free()
	game = game_scene.instantiate() as Game
	_hook_up_game(game)
	
	add_child(game)
	transition_cover.open()
	
func _on_main_menu_settings():
	if state != UpperState.MainMenu:
		return
	pass

func _on_main_menu_credits():
	if state != UpperState.MainMenu:
		return
	pass

func _on_main_menu_quit():
	if state != UpperState.MainMenu:
		return
	pass

func _on_game_quit_to_main_menu():
	if state != UpperState.Game:
		return
	state = UpperState.MainMenu
	transition_cover.close()
	await transition_cover.done
	game.queue_free()
	main_menu = main_menu_scene.instantiate() as MainMenu
	_hook_up_main_menu(main_menu)
	
	add_child(main_menu)
	transition_cover.open()