extends Control

func _input(event) -> void:
	if event.is_action_pressed("pause"):
		change_pause_state()

func change_pause_state() -> void:
	#uma variável pega o estado atual de pause e usa ele pra modificar a tree
	var pause_state : bool = get_tree().paused
	get_tree().paused = not pause_state
	visible = not pause_state
	
func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_retomar_pressed() -> void:
	retomar()
	
func retomar()-> void:
	get_tree().paused = false
	visible = false
