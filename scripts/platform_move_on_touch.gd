extends Node

@onready var timer = $Timer
var moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (moving):
		self.position.x -= 110 * delta

func _on_area_2d_body_entered(body):
	timer.start(1)


func _on_timer_timeout():
	moving = true


func _on_area_2d_body_exited(body):
	timer.stop()
