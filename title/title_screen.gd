extends Node2D

@onready var fader = $Fader

signal game_started

# we dont want d pad entry to start the game, and for some reaosn snes controller
# pressing it automatically and start, so track them here
var d_pads = [11, 12, 13, 14]

func _input(event):
	if (event is InputEventKey or event is InputEventJoypadButton) and event.pressed:
		# dont start the game for dpad entry
		if (event is InputEventJoypadButton and event.button_index in d_pads):
			return
		fader.play("fade_to_start")

func start_game():
	game_started.emit()
