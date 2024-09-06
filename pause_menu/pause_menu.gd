extends Control

signal unpaused(method)
signal to_main

func pause():
	show()
	%ResumeButton.grab_focus()
	
func unpause():
	hide()

func _input(event):
	if event.is_action_pressed("pause"):
		unpaused.emit("pause_button")
		return
	if event.is_action_pressed("ui_cancel"):
		unpaused.emit("menu")

func _on_resume_button_pressed():
	unpaused.emit("menu")

func _on_main_menu_button_pressed():
	unpaused.emit("menu")
	get_tree().reload_current_scene()

func _on_quit_game_button_pressed():
	get_tree().quit()
