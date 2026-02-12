class_name ResolutionSetting
extends OptionButton

func _on_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_size(Vector2i(720, 432))
	elif index == 1:
		DisplayServer.window_set_size(Vector2i(1024, 576))
	elif index == 2:
		DisplayServer.window_set_size(Vector2i(1152, 648))
	elif index == 3:
		DisplayServer.window_set_size(Vector2i(1280, 720))
	elif index == 4:
		DisplayServer.window_set_size(Vector2i(1600, 880))
	elif index == 5:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
	elif index == 6:
		is_4k()
		if size.x >= 2560 and size.y >= 1440:
			DisplayServer.window_set_size(Vector2i(2560, 1440))
			print("4K APPLIED")
		else:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
			print("4K NOT APPLIED, FHD INSTEAD")

func is_4k():
	@warning_ignore("shadowed_variable_base_class")
	var size = DisplayServer.screen_get_size()
	print(size.x, size.y)
	return size.x and size.y
