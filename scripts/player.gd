extends CharacterBody2D
class_name Player

const SPEED = 80.0
const RUN_SPEED = 130.0
const BOUNCE_VELOCITY = -300
const INITIAL_JUMP_VELOCITY = -50
const CONTINUOUS_JUMP_VELOCITY = -50.0
const MAX_JUMP_VELOCITY = -250.0
const COYOTE_TIME_SECONDS = 0.1

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var coyote_timer = $CoyoteTimer
@onready var jump_sound = $jump_sound

var stopped = false
var dead = false
var was_on_floor = false
var jumping = false
var current_jump_velocity = 0
var speed = SPEED

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	coyote_timer.wait_time = COYOTE_TIME_SECONDS

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if stopped:
		animated_sprite.stop()
		
	if dead or stopped:
		velocity.x = 0
		velocity.y = 300
		move_and_slide()
		return
	
	if was_on_floor and !is_on_floor():
		coyote_timer.start()	
	
	if (Input.is_action_just_pressed("jump") 
			and (is_on_floor() or !coyote_timer.is_stopped())):
		jumping = true
		velocity.y = INITIAL_JUMP_VELOCITY
		jump_sound.play()
	if velocity.y < MAX_JUMP_VELOCITY:
		jumping = false
	if (Input.is_action_pressed("jump") && jumping):
		velocity.y += CONTINUOUS_JUMP_VELOCITY

		

	# Get the input direction (-1, 0, 1)
	var direction = Input.get_axis("move_left", "move_right")
	
	# Handle direction change
	if direction == -1:
		animated_sprite.flip_h = true
	elif direction == 1:
		animated_sprite.flip_h = false
		
	# handle animation change
	if is_on_floor():
		if direction:
			animated_sprite.play('run')
		else:
			animated_sprite.play('idle')
	else:
		animated_sprite.play('jump')
		
	if is_on_floor():
		if Input.is_action_pressed("run"):
			speed = RUN_SPEED
		else:
			speed = SPEED
	# handle the movement/deceleration.
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# check if player was on the floor during the last frame, before applying physics to this frame
	was_on_floor = is_on_floor()

	# apply physics changes
	move_and_slide()

func bounce():
	velocity.y = BOUNCE_VELOCITY

func die():
	dead = true
	animation_player.play('die')
