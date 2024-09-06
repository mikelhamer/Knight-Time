extends Node

signal coins_updated(total_coins)
signal game_over

const save_file_path = "user://knight_time.tres"

var level_coins = {}
var total_coins = {}
var checkpoint_position: Vector2
var current_level: String

func _ready():
	level_coins = {}
	total_coins = {}
	checkpoint_position = Vector2(0,0)
	save()

func save():
	save_level_coins()
	var save_data = SaveData.new()
	save_data.coins = total_coins
	save_data.checkpoint_position = checkpoint_position
	ResourceSaver.save(save_data, save_file_path)

func load():
	var save_data = ResourceLoader.load(save_file_path) as SaveData
	total_coins = save_data.coins
	checkpoint_position = save_data.checkpoint_position

func add_level_coin(id, position):
	level_coins[id] = position
	coins_updated.emit(level_coins.size() + total_coins.size())

func reset():
	level_coins = {}
	total_coins = {}
	checkpoint_position = Vector2(0, 0)
	save()
	coins_updated.emit(total_coins.size())
	
func over():
	level_coins = {}
	coins_updated.emit(total_coins.size())
	game_over.emit()
	
func save_level_coins():
	total_coins.merge(level_coins)
	level_coins = {}
	
