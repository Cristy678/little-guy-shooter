class_name tempEnemyCounter
extends Label

@onready var performanceManager: Node2D = get_parent().get_parent()

func _physics_process(_delta: float) -> void:
	self.text = str(performanceManager.currentEnemies)
