class_name Coin
extends Area2D

@onready var animation_player = $AnimationPlayer

static var id_sequence = 0

var id: String

func _ready():
	id_sequence += 1
	id = Game.current_level + "_" + str(id_sequence)

func _on_body_entered(body):
	print(id)
	animation_player.play("coin_get")
	Game.add_level_coin(id, global_position)
	
