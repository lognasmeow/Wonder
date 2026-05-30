extends Node

var jumpHeightMultiplier: float
var invertedWalking: bool
var invertedMouse: bool
var floorIciness: float

var modifierPaths: Array

func _ready():
	resetModifiers()
	resetModifierPaths()

func resetModifiers() -> void:
	jumpHeightMultiplier = 1
	invertedWalking = false
	invertedMouse = false
	floorIciness = 1

func resetModifierPaths() -> void:
	modifierPaths.clear()
	modifierPaths = ["res://Modifiers/DoubleJumpHeight/Mod_IncreasedJumpHeight.tscn",
					"res://Modifiers/InvertedWalking/Mod_InvertedWalking.tscn",
					"res://Modifiers/InvertedWalking/Mod_InvertedMouse.tscn",
					"res://Modifiers/InvertedWalking/Mod_IcyFloor.tscn",
					]
