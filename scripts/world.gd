extends Node2D

var levels = [
	"res://scenes/level_1.tscn"
]
var current_level_index = 0
var current_level: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func load_next_level():
	if (current_level):
		remove_child(current_level)
	var level_scene = load(levels[current_level_index]) as PackedScene
	current_level = level_scene.instantiate()
	add_child(current_level)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
