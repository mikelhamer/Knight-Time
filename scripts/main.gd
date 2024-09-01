extends Node

@onready var title_screen = $TitleScreen
@onready var hud = $HUD
@onready var animation_player = $AnimationPlayer

var levels := [
	"res://levels/level_1.tscn",
	"res://levels/level_2.tscn",
	"res://levels/level_3.tscn",
	"res://levels/level_4.tscn",
	"res://levels/credits.tscn",
]

var level_index := 0
var current_level

func load_level(index: int):
	if (current_level):
		remove_child(current_level)
	var level_scene = load(levels[index]) as PackedScene
	current_level = level_scene.instantiate()
	add_child(current_level)
	animation_player.play("RESET")
	
func load_next_level():
	level_index += 1
	load_level(level_index)
	
func _on_title_screen_game_started():
	remove_child(title_screen)
	load_level(level_index)
	hud.visible = true

func _on_level_completed():
	animation_player.play("fade_to_next_level")
