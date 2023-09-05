extends Area2D

var is_empty: bool:
	get:
		return  (!get_overlapping_areas() && !get_overlapping_bodies())
