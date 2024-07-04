extends Node

@onready var platform = $Platform
var player_on_platform = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (player_on_platform):
		platform.position.x -= 20 * delta





func _on_body_entered(body):
	player_on_platform = true
