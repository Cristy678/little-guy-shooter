class_name Gun
extends Sprite2D

@export var rotation_speed: float = 1.0

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	pass
