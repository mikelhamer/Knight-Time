extends Area2D

signal death

func _on_body_entered(body):
	print("Death!")
	death.emit()
	Engine.time_scale = .5
	$Timer.start(.5)


func _on_timer_timeout():
	Engine.time_scale = 1	
	get_tree().reload_current_scene()
