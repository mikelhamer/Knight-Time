extends Area2D

const MAX_HITS = 3

var speed = 50.0
var hits = 0
var lazer_time_seconds = 3.2
var lazer_speed = 130

@export var move = false;

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var killzone = $Killzone
@onready var weak_spot = $WeakSpot
@onready var animation_player = $AnimationPlayer
@onready var die_sound = $DieSound
@onready var i_frame_timer = $IFrameTimer
@onready var lazer_timer = $LazerTimer
@onready var lazer_origin = $LazerOrigin

var direction = 'left'

# Called when the node enters the scene tree for the first time.
func _ready():
	lazer_timer.wait_time = lazer_time_seconds
	# Clear any existing lazers on load to prevent weird effect of lazers staying on screen after death
	get_tree().get_nodes_in_group('lazers').all(func(lazer: Node):
		lazer.queue_free())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !move:
		return
	
	if ray_cast_left.is_colliding():
		direction = 'right';	
		
	elif ray_cast_right.is_colliding():
		direction = 'left';
		
	if direction == 'left':
		position.x -= speed * delta
		#scale = Vector2(2.36, 2.36)
		animated_sprite.flip_h = true	
	elif direction == 'right':
		position.x += speed * delta
		#scale = Vector2(-2.36, 2.36)
		animated_sprite.flip_h = false

func _on_weak_spot_body_entered(body):
	if i_frame_timer.time_left:
		return
	killzone.monitoring = false
	move = false
	body.bounce_high()
	animation_player.play("hit")
	hits += 1
	i_frame_timer.start()
	if hits >= MAX_HITS:
		animation_player.play('die')
		%Blocker.queue_free()
	else:
		speed += 20
		lazer_time_seconds -= .7
		lazer_timer.wait_time = lazer_time_seconds
		lazer_speed += 20
		die_sound.play()

func _on_killzone_body_entered(body):
	weak_spot.monitoring = false
	
func play_die():
	animated_sprite.play('die')	

func play_yum():
	animated_sprite.play('yum')
	

func _on_i_frame_timer_timeout():
	killzone.monitoring = true
	weak_spot.monitoring = true


func _on_laser_timer_timeout():
	if not i_frame_timer.time_left:
		shoot_laser()
	
func shoot_laser():
	animation_player.play("lazer")
	var lazer_scene = load('res://slimes/slime_boss/lazer.tscn') as PackedScene
	var lazer = lazer_scene.instantiate() as Lazer
	lazer.global_position = lazer_origin.global_position	
	lazer.speed = lazer_speed
	if direction == 'left':
		lazer.direction = Vector2.LEFT
	else:
		# stupid hack due to flipping using negative scale
		lazer.global_position.x += 25
	
	get_tree().root.add_child(lazer)
