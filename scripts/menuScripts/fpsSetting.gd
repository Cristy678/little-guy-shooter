class_name FpsSetting
extends OptionButton

func _ready() -> void:
	SettingsManager.load_settings()
	self.selected = SettingsManager.framerate
	
func _on_item_selected(index: int) -> void:
	SettingsManager.framerate = index
	SettingsManager.apply_settings()
	SettingsManager.save_settings()
