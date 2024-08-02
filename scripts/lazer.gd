extends Area2D
class_name Lazer

@onready var animation_player = $AnimationPlayer

var SPEED = 110
var direction = Vector2.RIGHT

func _ready():
	animation_player.play("shoot")

func _process(delta):
	position += direction * SPEED * delta
