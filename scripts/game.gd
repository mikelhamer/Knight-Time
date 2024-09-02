extends Node

signal coins_updated(total_coins)
signal game_over

var level_coins = 0
var total_coins = 0

func add_level_coin():
	level_coins += 1
	coins_updated.emit(level_coins + total_coins)

func reset():
	level_coins = 0
	total_coins = 0
	coins_updated.emit(total_coins)
	
func over():
	level_coins = 0
	coins_updated.emit(total_coins)
	game_over.emit()
