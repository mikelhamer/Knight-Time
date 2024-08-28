extends Node2D
class_name Level

@onready var checkpoints = $Checkpoints
@onready var complete_level: Area2D = $CompleteLevel
@onready var player_start = $PlayerStart
@onready var player = $Player

var current_checkpoint: Node2D 

signal checkpoint_reached
signal completed

# Called when the node enters the scene tree for the first time.
func _ready():
	if (complete_level):
		complete_level.body_entered.connect(_on_level_completed)
	if (checkpoints):
		for checkpoint in checkpoints.get_children():
			checkpoint.checkpoint_reached.connect(_on_checkpoint_reached)
	
func _on_checkpoint_reached(checkpoint: Node2D):
	current_checkpoint = checkpoint
	checkpoint_reached.emit(checkpoint)
	
func _on_level_completed(player: Player):
	player.stop()
	Game.level_coins = 0
	completed.emit()
	
