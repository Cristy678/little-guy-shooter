class_name ResolutionSetting
extends OptionButton

func _ready() -> void:
	SettingsManager.load_settings()
	self.selected = SettingsManager.resolution
	
func _on_item_selected(index: int) -> void:
	SettingsManager.resolution = index
	SettingsManager.apply_settings()
	SettingsManager.save_settings()
