extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _on_body_entered(body):
	Engine.time_scale = .5
	body.die()
	$Timer.start(.5)


func _on_timer_timeout():
	Engine.time_scale = 1	
	get_tree().reload_current_scene()
