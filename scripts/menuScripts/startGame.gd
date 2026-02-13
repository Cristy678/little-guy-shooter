class_name StartScript
extends Node2D

@onready var menuContent: CenterContainer = get_parent().get_node("menuContent")
@onready var hsLabel: Label = get_parent().get_node("highscoreLabel")
@onready var hsCount: Label = get_parent().get_node("hSCounter")
@onready var startLabel: Label = get_parent().get_node("startLabel")
@onready var logo: Sprite2D = get_parent().get_node("Logo")

var spacePressed = false

func _ready() -> void:
	hsCount.text = str(HighscoreLoader.loadHighscore())
	hsLabel.visible = false
	hsCount.visible = false
	startLabel.visible = true
	logo.visible = true
	menuContent.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		if spacePressed == false:
			print("MENU ENTERED")
			startLabel.visible = false
			logo.visible = false
			menuContent.visible = true
			hsLabel.visible = true
			hsCount.visible = true
			spacePressed = true
		pass
