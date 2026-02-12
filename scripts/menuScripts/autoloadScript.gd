class_name AutoloadNode
extends Node2D

func _ready() -> void:
	SettingsManager.load_settings()
	SettingsManager.apply_settings()
