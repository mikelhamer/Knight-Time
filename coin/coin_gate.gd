extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var blocks = $Area2D/Blocks
@onready var label = $Label

@export var coins_required = 1

func _ready():
	label.text = "%s coins to pass!" % coins_required

func _on_area_2d_body_entered(body):
	if (Game.level_coins.size() + Game.total_coins.size() >= coins_required):
		label.text = "Good job!"
		animation_player.play("gate_open")
