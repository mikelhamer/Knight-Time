extends Node

@onready var title_screen = $TitleScreen
@onready var world = $World

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_title_screen_game_started():
	remove_child(title_screen)
	world.load_next_level()
