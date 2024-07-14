extends Node

@onready var title_screen = $TitleScreen
@onready var hud = $HUD
@onready var world = $World

func _on_title_screen_game_started():
	remove_child(title_screen)
	world.load_next_level()
	hud.visible = true
