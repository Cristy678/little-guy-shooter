class_name Player
extends CharacterBody2D

var bullet_scene = preload("res://scenes/bullet.tscn")
@export var hp = 100
@export var ammo = 100
@export var loadedammo = 0
@export var speed = 320
@onready var animated_sprite: AnimatedSprite2D = $Player
@onready var ammoHUD: Label = get_parent().get_node("UIscreen/AmmoHUD")
@onready var loadammoHUD: Label = get_parent().get_node("UIscreen/LoadAmmoHUD")
@onready var hpHUD: Label = get_parent().get_node("UIscreen/HpHUD")
@onready var scoreSystem: Node2D = get_parent().get_node("ScoreControl")
@onready var gun: Sprite2D = $Player/Gun01

func _ready() -> void:
	ammoHUD.text = str(ammo)
	loadammoHUD.text = str(loadedammo)
	hpHUD.text = str(hp)
	
func _physics_process(_delta: float) -> void:
	hpHUD.text = str(hp)
	ammoHUD.text = str(ammo)
	loadammoHUD.text = str(loadedammo)
	if hp <= 0:
		scoreSystem.Combo = 0
		animated_sprite.play("DEADCHAR01")
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
				pass
			pass
	
func _on_player_animation_finished() -> void:
	queue_free()
	print("PLAYER KILLED")
	get_tree().quit()
	pass
