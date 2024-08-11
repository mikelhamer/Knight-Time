extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if body is Player:
		body.die()
		timer.start()

func _on_timer_timeout():
	Game.subtract_level_coins()
	Game.died.emit()
