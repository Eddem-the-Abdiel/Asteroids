extends Area2D

@export var SPEED : float = 500.0

var moviment_vector : Vector2 =  Vector2 (0, -1)

func _physics_process(delta) -> void:
	calculate_moviment(delta)

func calculate_moviment(delta) -> void:
	global_position += moviment_vector.rotated(rotation) * SPEED * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void :
	queue_free()
