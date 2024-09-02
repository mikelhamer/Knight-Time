class_name Coin
extends Area2D

@onready var animation_player = $AnimationPlayer

static var id_sequence = 0

var id: int

func _ready():
	id_sequence += 1
	id = id_sequence

func _on_body_entered(body):
	animation_player.play("coin_get")
	Game.add_level_coin(id, global_position)
