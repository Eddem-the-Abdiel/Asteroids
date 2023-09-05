extends Control

@onready var score_label: Label = $MarginContainer/VBoxContainer/Score_text
@onready var lifes = $MarginContainer/VBoxContainer/Lifes

var ui_life_scene = preload("res://User Interface/Hud/life_heart.tscn")

var score = 0
	
func update_score(points) -> void:
	#a variável score tem que ser convertida em string para se evitar erros
	score += points
	score_label.text = str("Score: " + str(score))

func init_lifes(amount)-> void:
	for ui_hearts in lifes.get_children():
		ui_hearts.queue_free()
	for itens in amount:
		var ui_life = ui_life_scene.instantiate()
		lifes.add_child(ui_life)
	
func on_points_updated(asteroid_size) -> void:
	var gained_points : int = 0
	match str(asteroid_size):
		"0":
			#LARGE ASTEROID
			gained_points = 100
		"1":
			#MEDIUM ASTEROID
			gained_points = 150
		"2":
			#SMALL ASTEROID
			gained_points = 200
			
			
	update_score( gained_points)
	
