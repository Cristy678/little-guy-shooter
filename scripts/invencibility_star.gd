class_name InvencibilityStar
extends Sprite2D

@onready var audioPlayer: AudioStreamPlayer2D = $audioPlayer
@onready var player: CharacterBody2D = get_parent().get_node("Body")
@onready var detectBox: Area2D = $detectBox
@onready var shapeBox: CollisionShape2D = detectBox.get_node("Shape")
@onready var speedDur: TextureProgressBar = get_parent().get_node("UIscreen/StarDuration")
@onready var timer: Timer = $timer
var IsObtained = false

func _ready() -> void:
	speedDur.visible = false

func _process(_delta: float) -> void:
	speedDur.max_value = 100
	speedDur.value = timer.time_left * 10
	position.y += sin(Time.get_ticks_msec() / 200.0) * 0.075

func _on_detect_box_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		if IsObtained == false:
			player.invencible = true
			print("INVENCIBILITY OBTAINED")
			IsObtained = true
			audioPlayer.play()
			speedDur.visible = true
			scale = Vector2(3, 3)
			await get_tree().create_timer(0.02).timeout
			scale = Vector2(2, 2)
			await get_tree().create_timer(0.02).timeout
			scale = Vector2(1, 1)
			await get_tree().create_timer(0.02).timeout
			shapeBox.disabled = true
			self.visible = false
			timer.start()
		pass
	pass

func _on_timer_timeout() -> void:
	player.invencible = false
	speedDur.visible = false
	print("INVENCIBILITY LOST")
	queue_free()
	pass
