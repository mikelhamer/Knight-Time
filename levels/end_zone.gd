extends Area2D

signal reached

func _on_body_entered(body):
	reached.emit()
