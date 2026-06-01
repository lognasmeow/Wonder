extends Node3D

func _ready():
	EventBus.modifierAdded.emit("res://Assets/Models/SpeedBoost/speedBoost.tscn", 20, 1.0, -1.0)
