extends Node3D

func _ready():
	EventBus.modifierAdded.emit("res://Assets/Models/Cow/cow.tscn", 10)
