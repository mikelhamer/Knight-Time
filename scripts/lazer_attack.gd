extends Node2D




func shoot():
	var lazer_scene = load('res://scenes/lazer.tscn') as PackedScene
	var lazer = lazer_scene.instantiate()
	add_child(lazer)



func _on_timer_timeout():
	shoot()
