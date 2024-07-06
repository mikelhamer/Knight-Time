extends Node

var coins = 0

@onready var hud = %HUD

func increment_coins():
	coins += 1
	hud.update_coins_label(coins)

func load_credits():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
