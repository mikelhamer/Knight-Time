extends Node2D


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
