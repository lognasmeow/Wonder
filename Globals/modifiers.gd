extends Node

var jumpHeightMultiplier: float
var invertedWalking: bool
var invertedMouse: bool
var floorIciness: float
var gravityMultiplier: float

var modifierPaths: Array

func _ready():
	resetModifiers()
	resetModifierPaths()

func resetModifiers() -> void:
	jumpHeightMultiplier = 1
	invertedWalking = false
	invertedMouse = false
	floorIciness = 1
	gravityMultiplier = 1

func resetModifierPaths() -> void:
	modifierPaths.clear()
	#modifierPaths = ["res://Modifiers/IncreasedJumpHeight/Mod_IncreasedJumpHeight.tscn",
					#"res://Modifiers/InvertedWalking/Mod_InvertedWalking.tscn",
					#"res://Modifiers/InvertedMouse/Mod_InvertedMouse.tscn",
					#"res://Modifiers/IcyFloor/Mod_IcyFloor.tscn",
					#"res://Modifiers/DecreasedGravity/Mod_DecreasedGravity.tscn",
					#"res://Modifiers/MyCat/Mod_MyCat.tscn",
					#"res://Modifiers/Cows/Mod_Cows.tscn",
					#"res://Modifiers/SpeedBoost/Mod_SpeedBoost.tscn",
					#"res://Modifiers/Spikes/Mod_Spikes.tscn"
					#]
	modifierPaths = [
					"res://Modifiers/Spikes/Mod_Spikes.tscn"
					]
