class_name logoMovement
extends Sprite2D

func _process(_delta: float) -> void:
	position.y += sin(Time.get_ticks_msec() / 200.0) * 0.22222222222
	pass
