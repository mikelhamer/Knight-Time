extends Node

@onready var static_body_2d = $StaticBody2D
var player_on_platform = false
@onready var this = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (player_on_platform):
		self.position.x -= 120 * delta

func _on_area_2d_body_entered(body):
	player_on_platform = true
