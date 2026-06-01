extends Node3D

func _ready():
	EventBus.modifierAdded.emit("res://Assets/Models/Cow/cow.tscn", 20, 2.5, 0.0)
