extends Area2D

const SPEED = 40.0

@export var move = false;

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var killzone = $Killzone
@onready var animation_player = $AnimationPlayer

var direction = 'left'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !move:
		return
	
	if ray_cast_left.is_colliding():
		direction = 'right';		
		
	elif ray_cast_right.is_colliding():
		direction = 'left';
		
	if direction == 'left':
		position.x -= SPEED * delta
		animated_sprite.flip_h = true;		
	elif direction == 'right':
		position.x += SPEED * delta
		animated_sprite.flip_h = false;

