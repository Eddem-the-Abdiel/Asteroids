extends Node2D

@onready var lasers =  $Laser
@onready var player = $Player

func _ready() -> void:
	player.connect("laser_shot", on_player_laser_shot)

func on_player_laser_shot(laser) ->void:
	lasers.add_child(laser)
