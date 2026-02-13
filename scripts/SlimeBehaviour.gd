class_name slime
extends AnimatedSprite2D

var bullet_scene = preload("res://scenes/bullet.tscn")
var bullet = bullet_scene.instantiate()
@onready var audioPlayer: AudioStreamPlayer2D = $audioPlayer
@onready var player: CharacterBody2D = get_parent().get_node("Body")
@onready var hitbox: Area2D = $hitbox
@onready var detectionRange: Area2D = $detectionRange
@onready var scoreSystem: Node2D = get_parent().get_node("ScoreControl")
@onready var timer: Timer = scoreSystem.get_node("Timer")
@onready var performanceManager: Node2D = get_parent()

const follow_speed = 0.00222222222222222222
var playerDetected = false
var IsKilled = false

func _ready() -> void:
	performanceManager.currentEnemies = performanceManager.currentEnemies + 1

func _process(_delta: float) -> void:
	if playerDetected == true:
		var target_position = player.global_position
		global_position = global_position.lerp(target_position, follow_speed)
	pass

func _on_hitbox_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		if IsKilled == false:
			if player.invencible == false:
				player.hit()
				player.hp = player.hp - 2
				print("HURT")
			pass
		pass
	pass

func _on_detection_range_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		playerDetected = true
		print("DETECTED")
	pass

func _on_detection_range_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		playerDetected = false
		print("LOST")
	pass

func _on_shot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		self.play("DEATHANIM01")
		if IsKilled == false:
			scoreSystem.Combo += 1
			scoreSystem.Score += 75 * scoreSystem.Combo / 10
			scoreSystem.on_combo_increase(scoreSystem.Combo/10)
		IsKilled = true
		flash()
		Engine.time_scale = 0.2
		audioPlayer.play()
		await get_tree().create_timer(0.02).timeout
		Engine.time_scale = 1.0
		playerDetected = false
		timer.stop()
		timer.start()
	pass

func flash():
	modulate = Color(1,0,0)
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1,0.5,0.5)
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1,1,1)

func _on_animation_finished() -> void:
	queue_free()
	performanceManager.currentEnemies = performanceManager.currentEnemies - 1
	print("DEAD")
	pass

func _on_apparition_signaler_screen_exited() -> void:
	set_process(false)

func _on_apparition_signaler_screen_entered() -> void:
	set_process(true)
