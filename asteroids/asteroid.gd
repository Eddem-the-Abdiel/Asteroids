extends Area2D

signal asteroid_exploded(asteroid_size)

func _on_asteroid_area_entered(area):
	if area.name == "Shot":
		emit_signal("asteroid_exploded", str("SMALL_ASTEROID"))

func _on_body_entered(body):
	if body is Player:
		var player = body
		print("playerdied")
		player.player_death()
