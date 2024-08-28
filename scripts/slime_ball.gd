extends Area2D

@export var speed = 40.0
@export var move_vertical = false;
@export var move_horizontal = false;

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown

var horizontal_direction = 'left'
var vertical_direction = 'up'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if move_horizontal:
		if ray_cast_left.is_colliding():
			horizontal_direction = 'right'
		elif ray_cast_right.is_colliding():
			horizontal_direction = 'left'
			
		if horizontal_direction == 'left':
			position.x -= speed * delta
		if horizontal_direction == 'right':
			position.x += speed * delta

	if move_vertical:
		if ray_cast_up.is_colliding():
			vertical_direction = 'down'
		elif ray_cast_down.is_colliding():
			vertical_direction = 'up'
			
		if vertical_direction == 'up':
			position.y -= speed * delta
		if vertical_direction == 'down':
			position.y += speed * delta
			
