class_name AmmoBox
extends Sprite2D

var alreadyCounted = 0
@onready var audioPlayer: AudioStreamPlayer2D = $audioPlayer
@onready var player: CharacterBody2D = get_parent().get_node("Body")
@onready var detectBox: Area2D = $detectBox
@onready var shapeBox: CollisionShape2D = detectBox.get_node("Shape")
@onready var performanceManager: Node2D = get_parent()

func _ready() -> void:
	performanceManager.currentItems = performanceManager.currentItems + 1

func _process(_delta: float) -> void:
	position.y += sin(Time.get_ticks_msec() / 200.0) * 0.075

func _on_detect_box_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		alreadyCounted = alreadyCounted + 1
		print(alreadyCounted)
		if alreadyCounted == 1:
			player.ammo = player.ammo + 20
			print("AMMO REFILLED")
			audioPlayer.play()
			scale = Vector2(3, 3)
			await get_tree().create_timer(0.02).timeout
			scale = Vector2(2, 2)
			await get_tree().create_timer(0.02).timeout
			scale = Vector2(1, 1)
			await get_tree().create_timer(0.02).timeout
			shapeBox.disabled = true
			self.visible = false
			queue_free()
			performanceManager.currentItems = performanceManager.currentItems - 1
		pass
	pass
