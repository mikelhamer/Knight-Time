extends CanvasLayer

@onready var coins_label = %CoinsLabel
@onready var congrats_label = %CongratsLabel

func _ready():
	coins_label.text = "Coins: " + str(Game.total_coins.size()) + "/202"
	if Game.total_coins.size() == 202:
		congrats_label.text = 'AMAZING!!!'
	
	
func _on_button_button_up():
	Game.reset()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
