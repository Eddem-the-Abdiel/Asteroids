extends Node2D

signal laser_trajectory

@onready var lasers : =  $Laser
@onready var player : = $Player
@onready var hud : = $Interface/HUD
@onready var asteroid := $Asteroid
@onready var player_respawn_pos : = $Player_respawn_pos
@onready var game_over := $Interface/Game_over

func _ready() -> void:
	hud.init_lifes(player.player_life)
	player.connect("laser_shot", on_player_laser_shot)
	player.connect("player_died", on_player_death)
	asteroid.connect("asteroid_exploded", update_hud_score)
	
func on_player_laser_shot(laser) ->void:
	lasers.add_child(laser)
	emit_signal("laser_trajectory")

func update_hud_score(size_of_asteroid):
	hud.on_points_updated(size_of_asteroid)

func on_player_death()->void:
	player.player_life -= 1
	update_ui_life()
	if player.player_life <= 0:
		await get_tree().create_timer(2).timeout
		game_over.visible = true
	else:
		await get_tree().create_timer(1).timeout
		player.respawn(player_respawn_pos.global_position)

func update_ui_life()->void:
	hud.init_lifes(player.player_life)
	
	
