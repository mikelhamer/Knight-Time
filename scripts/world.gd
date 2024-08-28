extends Node2D

@onready var animation_player = $AnimationPlayer

var levels := [
	"res://scenes/level_1.tscn",
	"res://scenes/level_2.tscn",
	"res://scenes/level_3.tscn",
	"res://scenes/level_4.tscn",
]
var current_level_index := 0
var current_level: Level
var current_checkpoint: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.died.connect(_on_died)

func load_next_level():
	if (current_level):
		current_level_index += 1
	if current_level_index == levels.size():
		get_tree().change_scene_to_file("res://scenes/credits.tscn")
		return
	load_level(current_level_index)
	animation_player.play("RESET")

func load_level(index: int):
	if (current_level):
		remove_child(current_level)
	var level_scene = load(levels[index]) as PackedScene
	current_level = level_scene.instantiate() as Level
	current_level.completed.connect(_on_level_completed)
	current_level.checkpoint_reached.connect(_on_checkpoint_reached)
	add_child(current_level)
	current_level.player.global_position = current_level.player_start.global_position	
	animation_player.play("RESET")

func _on_checkpoint_reached(checkpoint: Node2D):
	current_checkpoint = checkpoint
	

func _on_level_completed():
	animation_player.play("fade_to_next_level")
	
func _on_died():
	if current_level.current_checkpoint:
		current_level.player.dead = false
		current_level.player.global_position = current_level.current_checkpoint.global_position
	else:			
		reload_current_level()
	
func reload_current_level():
	remove_child(current_level)
	load_level(current_level_index)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
