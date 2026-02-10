class_name itemGenerator
extends Node2D

var coords: Vector2 = Vector2.ZERO
@onready var timer: Timer = get_node("Timer")
@onready var cam: Camera2D = get_parent().get_node("Body/Camera")
var ammoBox_scene = preload("res://scenes/ammo_box.tscn")
var speedShoes_scene = preload("res://scenes/speed_shoes.tscn")
var invenStar_scene = preload("res://scenes/invencibility_start.tscn")

func _ready() -> void:
	var randomTime = randi_range(45,75)
	timer.wait_time = randomTime
	timer.start()
	pass

func _on_timer_timeout() -> void:
	var randomOutcome = randi_range(1,40)
	if randomOutcome < 34:
		var instAmmo = ammoBox_scene.instantiate()
		instAmmo.global_position = global_position
		get_parent().add_child(instAmmo)
	elif randomOutcome > 33:
		var instSpeed = speedShoes_scene.instantiate()
		instSpeed.global_position = global_position
		get_parent().add_child(instSpeed)
	elif randomOutcome > 39:
		var instStar = invenStar_scene.instantiate()
		instStar.global_position = global_position
		get_parent().add_child(instStar)
	print(randomOutcome)
	var randomTime = randi_range(45,75)
	timer.wait_time = randomTime
	timer.stop()
	timer.start()
	pass
