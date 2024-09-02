class_name EndZone
extends Area2D

signal reached

func _on_body_entered(body):
	Game.save_level_coins()
	reached.emit()
