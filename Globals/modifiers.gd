extends Node

var jumpHeightMultiplier: float
var invertedWalking: bool
var modifierPaths: Array

func _ready():
	resetModifiers()
	resetModifierPaths()

func resetModifiers() -> void:
	jumpHeightMultiplier = 1
	invertedWalking = false

func resetModifierPaths() -> void:
	modifierPaths.clear()
	modifierPaths = ["res://Modifiers/DoubleJumpHeight/Mod_IncreasedJumpHeight.tscn",
					"res://Modifiers/InvertedWalking/Mod_InvertedWalking.tscn",
					]
