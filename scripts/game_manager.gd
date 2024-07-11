extends Node

@onready var hud = %HUD

var levels = {
	'1': 'res://scenes/level_1.tscn',
	'2': 'res://scenes/level_2.tscn',
	'credits': 'res://scenes/credits.tscn'
}

func increment_coins():
	State.add_level_coin()
	hud.update_coins_label()

func load_level(name: String):
	State.level_coins = 0
	get_tree().change_scene_to_file(levels[name])
