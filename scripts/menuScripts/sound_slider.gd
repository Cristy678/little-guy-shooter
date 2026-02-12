class_name SoundSlider
extends HSlider

func _ready() -> void:
	SettingsManager.load_settings()
	self.value = SettingsManager.sfx_volume
	
func _on_value_changed(value: float) -> void:
	SettingsManager.sfx_volume = value
	SettingsManager.apply_settings()
	SettingsManager.save_settings()
	pass
