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

var level_index := 3
var current_level: Node

func _ready():
	Game.reset()
	Game.game_over.connect(load_current_level)

func load_level(index: int):
	Coin.id_sequence = 0
	Game.current_level = "level" + str(level_index + 1)
	if (current_level):
		remove_child(current_level)
	var level_scene = load(levels[index]) as PackedScene
	current_level = level_scene.instantiate()
	var end_zone = current_level.get_node("EndZone") as EndZone
	if (end_zone):
		end_zone.reached.connect(_on_end_zone_reached)
	if Game.checkpoint_position:
		current_level.get_node("Player").global_position = Game.checkpoint_position
	add_child(current_level)
	animation_player.play("RESET")
	
func load_next_level():
	Game.checkpoint_position = Vector2(0, 0)
	Game.save_level_coins()
	Game.save()
	level_index += 1
	load_level(level_index)
	
func load_current_level():
	load_level(level_index)
	Game.load()
	if Game.checkpoint_position:
		for coin in current_level.get_tree().get_nodes_in_group("coins"):
			if Game.total_coins.has(coin.id):
				coin.queue_free()
	
func _on_title_screen_game_started():
	remove_child(title_screen)
	load_level(level_index)
	hud.visible = true

func _on_end_zone_reached():
	animation_player.play("fade_to_next_level")
