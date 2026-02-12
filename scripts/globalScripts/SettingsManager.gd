class_name GlobalSettingsManager
extends Node

const SAVE_PATH := "user://settings.cfg"

# ====== SETTINGS VARIABLES ======

var master_volume := 5.0
var music_volume := 5.0
var sfx_volume := 5.0

var window_mode := 0
var resolution := 2
var framerate := 0
var pixel_filter := false

# ================================

func save_settings():
	var config = ConfigFile.new()

	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)

	config.set_value("general", "window_mode", window_mode)
	config.set_value("general", "resolution", resolution)
	config.set_value("general", "framerate", framerate)
	config.set_value("general", "pixel_filter", pixel_filter)

	save_keybinds(config)

	config.save(SAVE_PATH)

func load_settings():
	var config = ConfigFile.new()

	if config.load(SAVE_PATH) != OK:
		print("No settings file found, using defaults")
		return

	master_volume = config.get_value("audio", "master_volume", 5.0)
	music_volume = config.get_value("audio", "music_volume", 5.0)
	sfx_volume = config.get_value("audio", "sfx_volume", 5.0)

	window_mode = config.get_value("general", "window_mode", 0)
	resolution = config.get_value("general", "resolution", 2)
	framerate = config.get_value("general", "framerate", 0)
	pixel_filter = config.get_value("general", "pixel_filter", false)
	
	load_keybinds(config)

func apply_settings():
	# Audio
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(master_volume)
	)

	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(music_volume)
	)

	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(sfx_volume)
	)

	# Window Mode
	if window_mode == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif window_mode == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif window_mode == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		
	# Resolution Scaling
	if resolution == 0:
		DisplayServer.window_set_size(Vector2i(720, 432))
	elif resolution == 1:
		DisplayServer.window_set_size(Vector2i(1024, 576))
	elif resolution == 2:
		DisplayServer.window_set_size(Vector2i(1152, 648))
	elif resolution == 3:
		DisplayServer.window_set_size(Vector2i(1280, 720))
	elif resolution == 4:
		DisplayServer.window_set_size(Vector2i(1600, 880))
	elif resolution == 5:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
	elif resolution == 6:
		var size = DisplayServer.screen_get_size()
		if size.x >= 2560 and size.y >= 1440:
			DisplayServer.window_set_size(Vector2i(2560, 1440))
			print("4K APPLIED")
		else:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
			print("4K NOT APPLIED, FHD INSTEAD")
		
	# Framerate
	if framerate == 0:
		Engine.max_fps = 60
	elif framerate == 1:
		Engine.max_fps = 120
	elif framerate == 2:
		Engine.max_fps = 240

	if pixel_filter:
		get_viewport().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_LINEAR
	else:
		get_viewport().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST

func save_keybinds(config: ConfigFile):
	for action in InputMap.get_actions():
		var events = InputMap.action_get_events(action)

		if events.size() > 0:
			config.set_value("keybinds", action, events[0])

func load_keybinds(config: ConfigFile):
	if not config.has_section("keybinds"):
		return

	for action in config.get_section_keys("keybinds"):
		var event = config.get_value("keybinds", action)

		if event is InputEvent:
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
