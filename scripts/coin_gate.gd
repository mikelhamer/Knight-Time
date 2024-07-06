extends Node2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer
@onready var blocks = $Area2D/Blocks

func _on_area_2d_body_entered(body):
	if (game_manager.coins >= 20):
		animation_player.play("gate_open")
