class_name Bullet
extends Area2D

@export var direction: Vector2
const SPEED = 30

func _physics_process(_delta: float) -> void:
	global_position += direction * SPEED
	rotation = direction.angle()
	scale = Vector2(1.2, 0.8)
	pass
