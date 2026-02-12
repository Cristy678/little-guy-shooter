class_name KeybindRebinder
extends Button

@export var input_action := ""
var is_listening := false
var action_to_rebind := ""

func _ready() -> void:
	text_change()

func text_change():
	SettingsManager.load_settings()
	self.text = get_action_key(str(input_action))
	
func start_rebind(action_name: String):
	is_listening = true
	action_to_rebind = action_name

func _input(event):
	if not is_listening:
		return

	if event is InputEventKey and event.pressed:
		rebind_action(action_to_rebind, event)
		is_listening = false
		action_to_rebind = ""

func rebind_action(action_name: String, new_event: InputEvent):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, new_event)
	print("Rebound ", action_name)
	SettingsManager.save_settings()
	text_change()

func _on_pressed() -> void:
	start_rebind(input_action)
	pass

func get_action_key(action_name: String) -> String:
	var events = InputMap.action_get_events(action_name)
	if events.size() > 0:
		if events[0] is InputEventKey:
			return events[0].as_text()
	return "None"
