extends Area2D

signal checkpoint_reached

func _on_body_entered(body):
	checkpoint_reached.emit(self)
