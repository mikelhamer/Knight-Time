extends Area2D

signal checkpoint_reached

var reached = false

func _on_body_entered(body):
	if !reached:
		reached = true
		checkpoint_reached.emit(self)
