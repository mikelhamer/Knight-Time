extends Node

@export var enabled := true

func _ready():
	if enabled:
		$TimeForAdventure.play()
