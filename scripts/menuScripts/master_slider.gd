class_name MasterSlider
extends HSlider

func _on_value_changed(value: float) -> void:
	var db = linear_to_db(max(value, 0.001))
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, db)
	pass
