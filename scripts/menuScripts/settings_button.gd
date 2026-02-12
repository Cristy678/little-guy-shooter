class_name BackButton
extends TextureButton

@onready var settingsMenu: Control = get_parent().get_parent().get_parent().get_node("settingsStuff")

func _ready() -> void:
	settingsMenu.visible = false

func _on_pressed() -> void:
	get_parent().get_parent().visible = false
	settingsMenu.visible = true
