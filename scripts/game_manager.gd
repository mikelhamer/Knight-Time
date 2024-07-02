extends Node

var coins = 0

@onready var hud = %HUD

func increment_coins():
	coins += 1
	hud.update_coins_label(coins)
