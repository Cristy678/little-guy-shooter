class_name MusicSlider
extends HSlider

func _ready() -> void:
	SettingsManager.load_settings()
	self.value = SettingsManager.music_volume
	
func _on_value_changed(value: float) -> void:
	SettingsManager.music_volume = value
	SettingsManager.apply_settings()
	SettingsManager.save_settings()
	pass
