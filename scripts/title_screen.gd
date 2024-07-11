extends Node2D

signal game_started

func _input(event):
	if event is InputEventKey and event.pressed:
		game_started.emit()
