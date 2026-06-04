extends Control

signal exitingCredits

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		exitingCredits.emit()
