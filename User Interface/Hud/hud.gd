extends Control

@onready var score_label: Label = $MarginContainer/Hbox_score/Points

var score = 200

func _ready():
	update_score()
	
func update_score() -> void:
	#a variável score tem que ser convertida em string para se evitar erros
	score_label.text = str(score)
	pass

func update_lifes() -> void:
	pass
	
func on_points_updated() -> void:
	pass
