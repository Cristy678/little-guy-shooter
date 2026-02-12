class_name score_control
extends Node2D

@export var Score = 0
@export var Combo = 0
@export var combo_grace := 0.5
@export var hasStarted = false
@onready var audioCombo: AudioStreamPlayer2D = $audioCombo
@onready var audioLost: AudioStreamPlayer2D = $audioLost
@onready var GUI: CanvasLayer = get_parent().get_node("UIscreen")
@onready var ScoreCounter: Label = GUI.get_node("ScoreCount")
@onready var ComboTimer: Label = GUI.get_node("ComboTimer")
@onready var ComboHUD: Label = GUI.get_node("ComboHUD")
@onready var ComboDur: TextureProgressBar = GUI.get_node("ComboDuration")
@onready var Countdown: Timer = $Timer

func _ready() -> void:
	audioCombo.pitch_scale = 0.5
	ScoreCounter.text = str(Score)
	ComboHUD.text = str(Combo)
	ComboTimer.text = str(int(Countdown.time_left))

func _process(delta: float) -> void:
	ScoreCounter.text = str(Score)
	ComboHUD.text = str(Combo)
	ComboHUD.scale = ComboHUD.scale.lerp(Vector2.ONE, 10 * delta)
	ComboTimer.text = str(int(Countdown.time_left))
	ComboDur.max_value = 100
	ComboDur.value = Countdown.time_left * 10
	ComboDur.tint_progress = Color(Countdown.time_left/10,Countdown.time_left/10,Countdown.time_left/10)

func on_combo_increase(value):
	audioCombo.pitch_scale = audioCombo.pitch_scale + value / 5
	audioCombo.play()
	ComboHUD.scale = Vector2(1.4+value, 1.4+value)
	await get_tree().create_timer(0.025).timeout
	ComboHUD.scale = Vector2(1.2+value/2, 1.2+value/2)
	await get_tree().create_timer(0.025).timeout
	ComboHUD.scale = Vector2(1, 1)

func _on_timer_timeout() -> void:
	Combo = 0
	audioLost.play()
	ComboHUD.modulate = Color(0, 0, 1)
	ComboHUD.scale = Vector2(1.4, 1.4)
	await get_tree().create_timer(0.075).timeout
	ComboHUD.modulate = Color(0.5, 0.5, 1)
	ComboHUD.scale = Vector2(1.2, 1.2)
	await get_tree().create_timer(0.075).timeout
	ComboHUD.modulate = Color(1, 1, 1)
	ComboHUD.scale = Vector2(1, 1)
