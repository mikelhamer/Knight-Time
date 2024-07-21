extends StaticBody2D

const SPEED = 280
const FALL_TRIGGER_TIMEOUT = .25

var falling = false

func _process(delta):
	if falling:
		position.y += SPEED * delta
	

func _on_fall_trigger_body_entered(body):
	$Timer.start(FALL_TRIGGER_TIMEOUT)

func _on_timer_timeout():
	falling = true
