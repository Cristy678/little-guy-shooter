class_name Bullet
extends Area2D

@export var direction: Vector2
@onready var signaler: VisibleOnScreenNotifier2D = $apparitionSignaler
const SPEED := 30

func _physics_process(_delta: float) -> void:
	global_position += direction * SPEED
	rotation = direction.angle()
	scale = Vector2(1.2, 0.8)
	pass

func _on_apparition_signaler_screen_exited() -> void:
	print("BULLET DELETED FROM SCENE")
	queue_free()
