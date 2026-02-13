class_name tempEnemyCounter
extends Label

@onready var performanceManager: Node2D = get_parent().get_parent()

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("debugMode"):
		self.visible = true
	else:
		self.visible = false
	self.text = str(performanceManager.currentEnemies)
