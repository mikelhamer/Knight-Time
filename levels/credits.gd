extends CanvasLayer

@onready var coins_label = %CoinsLabel
@onready var congrats_label = %CongratsLabel
@onready var fader = $Fader

func _ready():
	coins_label.text = "Coins: " + str(Game.total_coins.size()) + "/202"
	if Game.total_coins.size() == 202:
		congrats_label.text = 'AMAZING!!! :D'
	%Button.grab_focus()
	
func _on_button_button_up():
	fader.play("fade_to_main_menu")

func to_main_menu():
	Game.reset()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
