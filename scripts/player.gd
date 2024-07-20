extends CharacterBody2D
class_name Player

# Inspector properties
@export var move_speed := 140.0
@export var jump_height := 50.00
@export var jump_seconds_to_peak := 0.4
@export var jump_seconds_to_descent := .3
@export var coyote_seconds := .1
# Child Nodes
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var coyote_timer = $CoyoteTimer
@onready var jump_sound = $jump_sound
# Calculated jump properties
# https://www.youtube.com/watch?v=FvFx1R3p-aw
@onready var jump_velocity: float = ((2.0 * jump_height) / jump_seconds_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_seconds_to_peak * jump_seconds_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_seconds_to_descent * jump_seconds_to_descent)) * -1.0
# Player state
var dead := false
var stopped := false
var was_on_floor := false
var input_direction := 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	coyote_timer.wait_time = coyote_seconds

func _physics_process(delta):
	if stopped:
		animated_sprite.stop()
		return
	if dead:
		velocity.x = 0
		velocity.y = 300
		move_and_slide()
		return
	
	# Apply gravity
	velocity.y += get_gravity() * delta
	
	# Handle horizontal movement
	input_direction = get_input_direction()
	if input_direction:
		velocity.x = input_direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	# Check if entering coyote time
	if just_ran_off_floor():
		coyote_timer.start()	
	
	# Jump
	if jump_just_pressed() and can_jump():
		jump()

	# Update floor check
	was_on_floor = is_on_floor()

	# Flip sprite to match input direction
	flip_sprite_for_input_direction()

	# Apply animation changes
	update_animation()

	# Apply physics changes
	move_and_slide()

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump_just_pressed():
	return Input.is_action_just_pressed("jump")

func can_jump() -> bool:
	return not velocity.y < 0  and \
			(is_on_floor() or !coyote_timer.is_stopped())

func jump():
	velocity.y = jump_velocity
	jump_sound.play()

func get_input_direction() -> float:
	# Get the input direction (left = -1, neutral = 0, right = 1)
	return Input.get_axis("move_left", "move_right")

func flip_sprite_for_input_direction():
	if input_direction < 0:
		animated_sprite.flip_h = true
	elif input_direction > 0:
		animated_sprite.flip_h = false

func just_ran_off_floor():
	return was_on_floor and !is_on_floor()

func bounce():
	velocity.y = -320

func die():
	dead = true
	animation_player.play('die')
	
func stop():
	stopped = true

func update_animation():
	if is_on_floor():
		if input_direction:
			animated_sprite.play('run')
		else:
			animated_sprite.play('idle')
	else:
		animated_sprite.play('jump')
