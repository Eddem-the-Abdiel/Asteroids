extends CharacterBody2D

signal laser_shot(laser_node)

@onready var muzzle : Node2D = $muzzle

var laser_scene : = preload("res://Player/shot.tscn")

var shot_cool_down = false
var rate_of_fire = 0.25

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
	
	
