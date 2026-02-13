class_name FPSCounter
extends Label

func _physics_process(_delta: float) -> void:
	self.text = str(Engine.get_frames_per_second())
