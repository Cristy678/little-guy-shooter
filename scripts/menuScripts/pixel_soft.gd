class_name PixelOption
extends CheckBox

func _ready() -> void:
	SettingsManager.load_settings()
	self.button_pressed = SettingsManager.pixel_filter

func _on_toggled(toggled_on: bool) -> void:
	SettingsManager.pixel_filter = toggled_on
	SettingsManager.apply_settings()
	SettingsManager.save_settings()
