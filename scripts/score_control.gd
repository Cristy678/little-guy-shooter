class_name score_control
extends Node2D

@export var Score = 0
@export var Combo = 0
@export var hasStarted = false
@onready var GUI: CanvasLayer = get_parent().get_node("UIscreen")
@onready var ScoreCounter: Label = GUI.get_node("ScoreCount")
@onready var ComboTimer: Label = GUI.get_node("ComboTimer")
@onready var ComboHUD: Label = GUI.get_node("ComboHUD")
@onready var Countdown: Timer = $Timer

func _ready() -> void:
	ScoreCounter.text = str(Score)
	ComboHUD.text = str(Combo)
	ComboTimer.text = str(int(Countdown.time_left))

func _process(_delta: float) -> void:
	ScoreCounter.text = str(Score)
	ComboHUD.text = str(Combo)
	ComboTimer.text = str(int(Countdown.time_left))
	

func _on_timer_timeout() -> void:
	Combo = 0
