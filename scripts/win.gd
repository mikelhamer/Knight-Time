extends Area2D



@onready var animation_player = $AnimationPlayer
@onready var game = $"."


func _on_body_entered(body):
	animation_player.play("win")
