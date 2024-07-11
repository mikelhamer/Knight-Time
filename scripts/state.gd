extends Node

var level_coins = 0
var total_coins = 0
var won = false

func add_level_coin():
	level_coins += 1
	total_coins += 1

func subtract_level_coins():
	total_coins -= level_coins
	level_coins = 0

func reset():
	won = false
	level_coins = 0
	total_coins = 0
