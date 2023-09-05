extends CharacterBody2D

class_name Player

signal laser_shot(laser_node)
signal player_died

@export var ACCELERATION: float = 10.0
@export var MAXSPEED : float = 300.0
@export var SLOW_IN: float = 4.0
@export var ROTATION_SPEED: float = 250.0

@onready var muzzle : Node2D = $muzzle
@onready var sprite : Sprite2D = $Sprite2D
@onready var collision_shape: = $CollisionShape2D
@onready var timer = $Timer

var player_life : int = 3
var laser_scene : = preload("res://Player/shot.tscn")
var shot_cool_down : bool = false
var rate_of_fire: float = 0.25
var player_score :  int = 0
var is_alive : bool = true


func _physics_process(delta) -> void:
	var input_vector : = Vector2(0, Input.get_axis("move_foward", "move_backward"))
	#a func rotated muda o ângulo do input vector, pegando a rotação da tree player
	velocity += input_vector.rotated(rotation) * ACCELERATION 
	velocity = velocity.limit_length(MAXSPEED)
	move_and_slide()
	
	if Input.get_action_strength("rotate_right"):
		rotate(deg_to_rad( ROTATION_SPEED * delta))
	elif Input.get_action_strength("rotate_left"):
		rotate(deg_to_rad( -ROTATION_SPEED * delta))
		
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, SLOW_IN)
	
	var screen_size = get_viewport_rect().size
	if global_position.y < 0 :
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y :
		global_position.y = 0
	elif global_position.x < 0 :
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x :
		global_position.x = 0


func _input(_event)-> void:
	if Input.is_action_pressed("shoot"):
		if !shot_cool_down:
			#com o shot_cool_down sendo falso, o jogador está livre para atirar
			#se ele está livre e atira, ele ativa o cooldown 
			shot_cool_down = true
			shot_laser()
			await get_tree().create_timer(rate_of_fire).timeout
			shot_cool_down = false

func shot_laser()->void:
	var laser = laser_scene.instantiate()
	laser.global_position = muzzle.global_position
	laser.rotation = rotation
	emit_signal("laser_shot", laser)

func player_death()->void:
	if is_alive == true:
		is_alive = false
		emit_signal("player_died")
		sprite.visible = false
		process_mode = Node.PROCESS_MODE_DISABLED

func respawn( pos )-> void:
	global_position = pos
	is_alive = true
	sprite.visible = true
	start_invincibility()
	velocity = Vector2.ZERO
	process_mode = Node.PROCESS_MODE_INHERIT
	
func start_invincibility()->void:
	var invincible_time = 0.7
	collision_shape.disabled = true
	timer.wait_time = invincible_time
	timer.start()
	#print("torna o player invencível")

func _on_timer_timeout() -> void:
	#print("player pode morrer")
	collision_shape.set_deferred("disabled", false)
