extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	body.die()
	timer.start()

func _on_timer_timeout():
	State.subtract_level_coins()
	State.died.emit()
