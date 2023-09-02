extends CanvasLayer


func _on_start_pressed():
	print("Haki")
	#get_tree().change_scene_to_file("res://MainGame/main_game.tscn")

func _on_quit_pressed():
	get_tree().quit()
