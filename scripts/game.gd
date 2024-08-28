extends Node

signal coins_updated(total_coins)
signal died

var level_coins = 0
var total_coins = 0

func add_level_coin():
	level_coins += 1
	total_coins += 1
	coins_updated.emit(total_coins)

func subtract_level_coins():
	total_coins -= level_coins
	level_coins = 0
	coins_updated.emit(total_coins)

func reset():
	level_coins = 0
	total_coins = 0
	coins_updated.emit(total_coins)
