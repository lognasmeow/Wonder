extends Node3D

signal modifierCowsAdded(objectPath, amountToSpawn)

func _ready():
	modifierCowsAdded.emit("res://Assets/Models/Cow/cow.tscn", 10)
