class_name enemyGenerator
extends Node2D

var coords: Vector2 = Vector2.ZERO
@onready var timer: Timer = get_node("Timer")
@onready var cam: Camera2D = get_parent().get_node("CharacterBody2D/Camera")
var slimeEnemy = preload("res://scenes/slime.tscn")
var enragedEnemy = preload("res://scenes/enraged.tscn")

func _ready() -> void:
	var randomTime = randi_range(3,7)
	timer.wait_time = randomTime
	timer.start()
	pass

func _on_timer_timeout() -> void:
	var randomOutcome = randi_range(1,20)
	if randomOutcome < 18:
		var instSlime = slimeEnemy.instantiate()
		instSlime.global_position = global_position
		get_parent().add_child(instSlime)
	elif randomOutcome > 17:
		var instEnraged = enragedEnemy.instantiate()
		instEnraged.global_position = global_position
		get_parent().add_child(instEnraged)
	print(randomOutcome)
	var randomTime = randi_range(3,7)
	timer.wait_time = randomTime
	timer.stop()
	timer.start()
	pass
