extends Node

@onready var hud = %HUD

func increment_coins():
	State.add_level_coin()
	hud.update_coins_label()
