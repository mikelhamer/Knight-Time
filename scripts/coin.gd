extends Area2D

@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	animation_player.play("coin_get")
	Game.add_level_coin()
