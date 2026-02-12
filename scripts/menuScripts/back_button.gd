class_name SettingsButton
extends Button

@onready var menuContent: CenterContainer = get_parent().get_parent().get_node("menuContent")

func _on_pressed() -> void:
	get_parent().visible = false
	menuContent.visible = true
