extends Control

func restart_game() -> void:
	get_tree().reload_current_scene()
	
func _on_tentar_de_novo_pressed() -> void:
	restart_game()
