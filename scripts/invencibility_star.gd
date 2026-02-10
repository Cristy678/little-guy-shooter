class_name InvencibilityStar
extends Sprite2D

@onready var player: CharacterBody2D = get_parent().get_node("Body")
@onready var detectBox: Area2D = $detectBox
@onready var timer: Timer = $timer
var IsObtained = false

func _on_detect_box_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		if IsObtained == false:
			player.invencible = true
			print("INVENCIBILITY OBTAINED")
			self.visible = false
			IsObtained = true
			timer.start()
		pass
	pass

func _on_timer_timeout() -> void:
	player.invencible = false
	print("INVENCIBILITY LOST")
	queue_free()
	pass
