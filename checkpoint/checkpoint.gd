extends Area2D

var reached = false

func _on_body_entered(body):
	if !reached:
		reached = true
		Game.save()
