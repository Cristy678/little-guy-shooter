class_name Bullet
extends Area2D

@export var direction: Vector2
const SPEED = 20

func _physics_process(_delta: float) -> void:
	global_position += direction * SPEED
	pass
