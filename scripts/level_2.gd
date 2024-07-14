extends Level

func _on_complete_level_body_entered(body):
	$Player.stopped = true
	State.level_coins = 0
	completed.emit()
