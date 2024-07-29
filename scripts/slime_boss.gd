extends Area2D

const SPEED = 60.0
const MAX_HITS = 7
var hits = 0

@export var move = false;

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var killzone = $Killzone
@onready var weak_spot = $WeakSpot
@onready var animation_player = $AnimationPlayer
@onready var die_sound = $DieSound
@onready var i_frame_timer = $IFrameTimer

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

func _on_weak_spot_body_entered(body):
	if i_frame_timer.time_left:
		return
	killzone.monitoring = false
	move = false
	body.bounce_high()
	animation_player.play("hit")
	hits += 1
	print(hits)
	i_frame_timer.start()
	if hits >= MAX_HITS:
		print("death")
		animation_player.play('die')	
	else:
		die_sound.play()

func _on_killzone_body_entered(body):
	weak_spot.monitoring = false
	
func play_die():
	print("die")
	animated_sprite.play('die')	

func play_yum():
	print("yum")
	animated_sprite.play('yum')
	

func _on_i_frame_timer_timeout():
	killzone.monitoring = true
	weak_spot.monitoring = true
