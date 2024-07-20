extends Node2D
class_name Level

@onready var complete_level: Area2D = $CompleteLevel

signal completed

# Called when the node enters the scene tree for the first time.
func _ready():
	if (complete_level):
		complete_level.body_entered.connect(_on_level_completed)
	
func _on_level_completed(player: Player):
	player.stop()
	Game.level_coins = 0
	completed.emit()
