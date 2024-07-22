extends AnimatableBody2D

const SPEED = 200
const MOVE_SECONDS = 15

@onready var move_timer = $MoveTimer
var start_position

func _ready():
	start_position = self.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!move_timer.is_stopped()):
		self.position.x -= SPEED * delta

func _on_area_2d_body_entered(body):
	if (move_timer.is_stopped()):
		move_timer.start(MOVE_SECONDS)

func _on_move_timer_timeout():
	self.position = start_position
