extends Node

signal coins_updated(total_coins)
signal game_over

var level_coins = {}
var total_coins = {}
var player: Player

func save():
	total_coins.merge(level_coins)
	level_coins = {}
	var save_data = SaveData.new()
	save_data.coins = total_coins
	ResourceSaver.save(save_data, "res://save_data/save_data.tres")

func load():
	var save_data = ResourceLoader.load("res://save_data/save_data.tres") as SaveData
	total_coins = save_data.coins

func add_level_coin(id, position):
	level_coins[id] = position
	print(id, position)
	coins_updated.emit(level_coins.size() + total_coins.size())

func reset():
	level_coins = {}
	total_coins = {}
	coins_updated.emit(total_coins.size())
	
func over():
	level_coins = {}
	coins_updated.emit(total_coins.size())
	game_over.emit()
