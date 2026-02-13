class_name enemyGenerator
extends Node2D

var coords: Vector2 = Vector2.ZERO
@onready var timer: Timer = $Timer
@onready var cam: Camera2D = get_parent().get_node("Body/Camera")
@onready var signaler: VisibleOnScreenNotifier2D = $apparitionSignaler
@onready var performanceManager: Node2D = get_parent()
var slimeEnemy = preload("res://scenes/slime.tscn")
var enragedEnemy = preload("res://scenes/enraged.tscn")

func _ready() -> void:
	var randomTime = randi_range(6,10)
	timer.wait_time = randomTime
	timer.start()
	pass

func _on_timer_timeout() -> void:
	if performanceManager.currentEnemies <= performanceManager.maxEnemies:
		create_Enemy()
	pass
	var randomTime = randi_range(6,10)
	timer.wait_time = randomTime
	timer.stop()
	timer.start()
	pass

func create_Enemy():
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
pass

func _on_apparition_signaler_screen_exited() -> void:
	set_process(false)

func _on_apparition_signaler_screen_entered() -> void:
	set_process(true)
