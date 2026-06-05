extends Node

@warning_ignore("unused_signal")
signal modifierAdded(objectPath: String, amountToSpawn: int, scaleModifier: float, yOffset: float)

@warning_ignore("unused_signal")
signal speedBoostTouched

@warning_ignore("unused_signal")
signal spikesModifierAdded

@warning_ignore("unused_signal")
signal playerSquished

@warning_ignore("unused_signal")
signal spikesReload


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
