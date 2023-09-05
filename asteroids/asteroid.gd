class_name Asteroid extends Area2D

signal asteroid_exploded(asteroid_size, asteroid_position)

enum Asteroid_size{LARGE, MEDIUM , SMALL}

@export var size:= Asteroid_size.MEDIUM
@export var SPEED : int = 50

@onready var sprite : Sprite2D = $Sprite2D
@onready var coll_shape : CollisionShape2D = $CollisionShape2D

var moviment_vector: Vector2 = Vector2(0,-1)

func _ready():
	rotation = randf_range(0, 2*PI)
	
	match size:
		Asteroid_size.LARGE:
			SPEED = randi_range(25,75)
			sprite.texture = preload("res://asteroids/big_asteroid.png")
			coll_shape.set_deferred("shape", preload("res://asteroids/coll_shape_resources/big_asteroid.tres") )
			
		Asteroid_size.MEDIUM:
			SPEED = randi_range(50, 100)
			sprite.texture = preload("res://asteroids/medium_asteroid.png")
			coll_shape.set_deferred("shape", preload("res://asteroids/coll_shape_resources/medium_asteroid.tres") )
		Asteroid_size.SMALL:
			SPEED = randi_range(75, 150)
			sprite.texture = preload("res://asteroids/small_asteroid.png")
			coll_shape.set_deferred("shape", preload("res://asteroids/coll_shape_resources/small_asteroid.tres") )
	
func _physics_process(delta):
	global_position += moviment_vector.rotated(rotation) * SPEED * delta
	
	var radius = coll_shape.shape.radius
	var screen_size = get_viewport_rect().size
	if (global_position.y + radius ) < 0 :
		global_position.y = screen_size.y + radius
	elif (global_position.y -  radius )> screen_size.y :
		global_position.y = -radius
		
	elif (global_position.x + radius) < 0 :
		global_position.x = screen_size.x + radius
	elif (global_position.x - radius) > screen_size.x :
		global_position.x = -radius
		

func explode():
	pass

func _on_asteroid_area_entered(area)->void:
	if area.get_parent().name == "Laser":
		emit_signal("asteroid_exploded", size, global_position)
		queue_free()

func _on_body_entered(body):
	if body is Player:
		var player = body
		player.player_death()
