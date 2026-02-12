class_name WindowSetting
extends OptionButton

func _on_item_selected(index: int) -> void:
	if index == 0:
		get_window().mode = Window.MODE_WINDOWED
	elif index == 1:
		get_window().mode = Window.MODE_FULLSCREEN
	elif index == 2:
		get_window().mode = Window.MODE_MAXIMIZED
