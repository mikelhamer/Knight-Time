extends CharacterBody2D
class_name Player

# Inspector properties
@export var move_speed := 140.0
@export var swim_speed := 80.0
@export var jump_height := 50.00
@export var jump_seconds_to_peak := 0.4
@export var jump_seconds_to_descent := .3
@export var coyote_seconds := .1
@export var water_gravity = 5
# Child Nodes
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var coyote_timer = $CoyoteTimer
@onready var jump_sound = $jump_sound
@onready var swim_sound = $swim_sound
@onready var swim_float_timer = $SwimFloatTimer
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
var bouncing = false
var in_water = false
var was_swim_up := false


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
	var speed = swim_speed if in_water else move_speed
	if input_direction:
		velocity.x = input_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	# Check if entering coyote time
	if just_ran_off_floor():
		coyote_timer.start()	
		
	# Check if max height of swim up reached
	if just_reach_swim_up_height():
		swim_float_timer.start()
		
		
	
	# Jump
	if jump_just_pressed() and can_jump():
		jump()
	
	# Reevaluate bouncing
	if bouncing and is_on_floor():
		bouncing = false

	# Update floor check
	was_on_floor = is_on_floor()
	
	# Update water swim up check
	was_swim_up = in_water and velocity.y < 0

	# Flip sprite to match input direction
	flip_sprite_for_input_direction()

	# Apply animation changes
	update_animation()

	# Apply physics changes
	move_and_slide()

func get_gravity() -> float:
	var jumping = (velocity.y < 0.0 and Input.is_action_pressed("jump")) and !bouncing
	var gravity = jump_gravity if jumping else fall_gravity
	if in_water:
		print("water grav")
		gravity *= .1
	return gravity

func jump_just_pressed():
	return Input.is_action_just_pressed("jump")
	
func can_jump() -> bool:
	if in_water:
		return true
	return not velocity.y < 0  and \
			(is_on_floor() or !coyote_timer.is_stopped())

func jump():
	if in_water:
		print("water jump!")
		if velocity.y < 0:
			velocity.y = -90
		else:
			velocity.y = -60

		swim_sound.play()
	else:
		velocity.y = jump_velocity
		jump_sound.play()
	
func bounce():
	velocity.y = jump_velocity * 1.4
	bouncing = true
	
func bounce_high():
	velocity.y = jump_velocity * 2.0
	bouncing = true

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
	
func just_reach_swim_up_height():
	return was_swim_up and (in_water && velocity.y >= 0)

func die():
	dead = true
	animation_player.play('die')
	
func stop():
	stopped = true

func update_animation():
	if in_water:
		animated_sprite.play("swim")
		return
	if is_on_floor():
		if input_direction:
			animated_sprite.play('run')
		else:
			animated_sprite.play('idle')
	else:
		animated_sprite.play('jump')


func _on_water_detector_body_entered(body):
	velocity.y = 20
	in_water = true


func _on_water_detector_body_exited(body):
	velocity.y= -100
	in_water = false
