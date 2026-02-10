class_name slime
extends AnimatedSprite2D

var bullet_scene = preload("res://scenes/bullet.tscn")
var bullet = bullet_scene.instantiate()
@onready var player: CharacterBody2D = get_parent().get_node("CharacterBody2D")
@onready var hitbox: Area2D = $hitbox
@onready var detectionRange: Area2D = $detectionRange
@onready var scoreSystem: Node2D = get_parent().get_node("ScoreControl")
@onready var timer: Timer = scoreSystem.get_node("Timer")

const follow_speed = 0.001
var playerDetected = false

func _process(_delta: float) -> void:
	if playerDetected == true:
		var target_position = player.global_position
		global_position = global_position.lerp(target_position, follow_speed)
	pass
	
func _on_hitbox_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		player.hp = player.hp - 2
		print("HURT")
	pass

func _on_detection_range_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		playerDetected = true
		print("DETECTED")
	pass

func _on_detection_range_body_exited(body: CharacterBody2D) -> void:
	if body == player:
		playerDetected = false
		print("LOST")
	pass

func _on_shot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		self.play("DEATHANIM01")
		playerDetected = false
		scoreSystem.Combo = scoreSystem.Combo + 1
		scoreSystem.Score = scoreSystem.Score + 50 * scoreSystem.Combo
		timer.stop()
		timer.start()
	pass

func _on_animation_finished() -> void:
	queue_free()
	print("DEAD")
	pass
