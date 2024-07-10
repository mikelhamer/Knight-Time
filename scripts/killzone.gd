extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
signal died

func _on_body_entered(body):
	body.die()
	died.emit()
	Engine.time_scale = .7
	$Timer.start(.5)


func _on_timer_timeout():
	Engine.time_scale = 1	
	get_tree().reload_current_scene()
