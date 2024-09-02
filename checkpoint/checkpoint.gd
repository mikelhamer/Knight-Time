extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer

var reached = false

func _ready():
	if Game.checkpoint_position:
		reached = true
		animation_player.play("already_reached")

func _on_body_entered(body):
	if !reached:
		reached = true
		animation_player.play("reached")
		audio_stream_player.play()
		Game.checkpoint_position = global_position
		Game.save()
