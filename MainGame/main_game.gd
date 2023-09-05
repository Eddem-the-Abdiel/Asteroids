extends Node2D

signal laser_trajectory

@onready var lasers : =  $Laser
@onready var player : = $Player
@onready var hud : = $Interface/HUD
@onready var asteroids := $Asteroids
@onready var player_spawn_pos : = $Player_spawn_pos
@onready var game_over := $Interface/Game_over
@onready var player_spawn_area = $Player_spawn_pos/Player_spawn_area

var asteroid_scene = preload("res://asteroids/asteroid.tscn")

func _ready() -> void:
	randomize()
	hud.init_lifes(player.player_life)
	player.connect("laser_shot", on_player_laser_shot)
	player.connect("player_died", on_player_death)
	for asteroid in asteroids.get_children():
		asteroid.connect("asteroid_exploded", on_asteroid_exploded)
	
func on_player_laser_shot(laser) ->void:
	lasers.add_child(laser)
	emit_signal("laser_trajectory")
	
	

func on_asteroid_exploded(size, pos):
	update_hud_score(size)
	for i in range(2):
		match size:
			Asteroid.Asteroid_size.LARGE:
				spawn_asteroids(Asteroid.Asteroid_size.MEDIUM, pos)
				
			Asteroid.Asteroid_size.MEDIUM:
				spawn_asteroids(Asteroid.Asteroid_size.SMALL, pos)
			
			Asteroid.Asteroid_size.SMALL:
				pass


func spawn_asteroids(size, pos):
	var ast =asteroid_scene.instantiate()
	ast.global_position = pos
	ast.size = size
	ast.connect("asteroid_exploded", on_asteroid_exploded)
	asteroids.call_deferred("add_child", ast)

func update_hud_score(size_of_asteroid)->void:
	hud.on_points_updated(size_of_asteroid)

func on_player_death()->void:
	player.player_life -= 1
	update_ui_life()
	if player.player_life <= 0:
		await get_tree().create_timer(2).timeout
		game_over.visible = true
	else:
		await get_tree().create_timer(1).timeout
		print(player_spawn_area.is_empty)
		while player_spawn_area.is_empty == false:
			# vai ser criado um timer para se chegar se há asteroides dentro
			#da área onde o player renasce
			await get_tree().create_timer(0.1).timeout
			
		player.respawn(player_spawn_pos.global_position)

func update_ui_life()->void:
	hud.init_lifes(player.player_life)
