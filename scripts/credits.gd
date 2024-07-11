extends CanvasLayer

func _on_button_button_up():
	State.reset()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
