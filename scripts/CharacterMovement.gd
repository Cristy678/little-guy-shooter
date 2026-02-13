class_name Player
extends CharacterBody2D

var bullet_scene = preload("res://scenes/bullet.tscn")
@export var hp := 100
@export var ammo := 100
@export var loadedammo := 0
@export var speed := 320
@export var invencible = false
@export var playerDead = false
@export var alreadyDead = false
@onready var animated_sprite: AnimatedSprite2D = $Player
@onready var ammoHUD: Label = get_parent().get_node("UIscreen/AmmoHUD")
@onready var loadammoHUD: Label = get_parent().get_node("UIscreen/LoadAmmoHUD")
@onready var hpHUD: Label = get_parent().get_node("UIscreen/HpHUD")
@onready var scoreSystem: Node2D = get_parent().get_node("ScoreControl")
@onready var gameOver: Control = get_parent().get_node("UIscreen/gameOverScreen")
@onready var highscoreCount: Label = gameOver.get_node("hSCount")
@onready var gun: Sprite2D = $Player/Gun01
@onready var audioLost: AudioStreamPlayer2D = $audioLoser
@onready var audioShoot: AudioStreamPlayer2D = $audioShoot
@onready var audioReload: AudioStreamPlayer2D = $audioReload

func _ready() -> void:
	ammoHUD.text = str(ammo)
	loadammoHUD.text = str(loadedammo)
	hpHUD.text = str(hp)
	gameOver.visible = false
	
func _physics_process(_delta: float) -> void:
	hpHUD.text = str(hp)
	ammoHUD.text = str(ammo)
	loadammoHUD.text = str(loadedammo)
	if hp <= 0:
		scoreSystem.Combo = 0
		animated_sprite.play("DEADCHAR01")
		await get_tree().create_timer(0.2).timeout
		if playerDead == false:
			audioPlay_onLost()
			playerDead = true
	else:
		var input_vector = Input.get_vector("move_left","move_right","move_up","move_down")
		velocity = input_vector * speed
		move_and_slide()
		if Input.is_action_pressed("move_right"):
			animated_sprite.flip_h = false
			animated_sprite.play("WALKCHAR01")
		elif Input.is_action_pressed("move_left"):
			animated_sprite.flip_h = true
			animated_sprite.play("WALKCHAR01")
		elif Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up"):
			animated_sprite.play("WALKCHAR01")
		else:
			animated_sprite.play("IDLECHAR01")
		pass
		if Input.is_action_just_pressed("reload"):
			if ammo > 0:
				loadedammo = loadedammo + 20
				ammo = ammo - 20
				ammoHUD.text = str(ammo)
				loadammoHUD.text = str(loadedammo)
				audioReload.play()
			pass
		if Input.is_action_just_pressed("shoot"):
			var bullet = bullet_scene.instantiate()
			if loadedammo > 0:
				bullet.global_position = gun.global_position
				bullet.direction = (get_global_mouse_position() - global_position).normalized()
				get_parent().add_child(bullet)
				loadedammo = loadedammo - 1
				ammoHUD.text = str(ammo)
				loadammoHUD.text = str(loadedammo)
				audioShoot.play()
			else:
				modulate = Color(0.5,0.5,0.5)
				await get_tree().create_timer(0.1).timeout
				modulate = Color(0.75,0.75,0.75)
				await get_tree().create_timer(0.1).timeout
				modulate = Color(1,1,1)
			pass

func hit():
	modulate = Color(1,0,0)
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1,0.5,0.5)
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1,1,1)
	pass

func _on_player_animation_finished() -> void:
	if alreadyDead == false:
		self.visible = false
		print("PLAYER KILLED")
		await get_tree().create_timer(0.5).timeout
		HighscoreLoader.loadHighscore()
		if scoreSystem.Score > HighscoreLoader.highscore:
			HighscoreLoader.saveHighscore(scoreSystem.Score)
		highscoreCount.text = str(HighscoreLoader.loadHighscore())
		gameOver.visible = true
		alreadyDead = true
	pass

func audioPlay_onLost():
	audioLost.play()
