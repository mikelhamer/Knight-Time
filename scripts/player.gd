extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var jump_sound = $jump_sound

var dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if dead:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

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
		
			
		
	# handle the movement/deceleration.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# apply physics changes
	move_and_slide()

func die():
	dead = true
	animation_player.play('die')
	print("death complete")
