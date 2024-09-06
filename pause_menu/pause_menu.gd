extends CanvasLayer

signal unpaused

func _input(event):
	if event.is_action_pressed("pause"):
		unpaused.emit()
