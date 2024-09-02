class_name EndZone
extends Area2D

signal reached

func _on_body_entered(body):
	Game.total_coins += Game.level_coins
	Game.level_coins = 0
	reached.emit()
