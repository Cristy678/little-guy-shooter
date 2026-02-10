class_name AmmoBox
extends Sprite2D

@onready var player: CharacterBody2D = get_parent().get_node("Body")
@onready var detectBox: Area2D = $detectBox

func _on_detect_box_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		player.ammo = player.ammo + 20
		print("AMMO REFILLED")
		queue_free()
	pass
