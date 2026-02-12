class_name SettingsNode
extends Control

@onready var generalPage: Control = $generalStuff
@onready var inputPage: Control = $inputStuff

func _on_general_pressed() -> void:
	generalPage.visible = true
	inputPage.visible = false

func _on_input_pressed() -> void:
	generalPage.visible = false
	inputPage.visible = true
