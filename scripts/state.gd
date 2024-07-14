extends Node

signal died

var level_coins = 0
var total_coins = 0

func add_level_coin():
	level_coins += 1
	total_coins += 1

func subtract_level_coins():
	print("subtracting %s coins", level_coins)
	total_coins -= level_coins
	level_coins = 0

func reset():
	level_coins = 0
	total_coins = 0
