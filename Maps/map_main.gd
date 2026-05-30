extends Node3D

@onready var playerSpawnPoint = $Marker3D_PlayerSpawn
@onready var player = $Player

signal transitioningOut
signal transitioningIn

func _ready():
	player.global_position = playerSpawnPoint.global_position
	transitioningIn.emit()
	await get_tree().create_timer(0.5).timeout


func _on_player_entered_fall_plane():
	transitioningOut.emit()
	await get_tree().create_timer(1.0).timeout
	Modifiers.resetModifiers()
	get_tree().reload_current_scene()


func _on_player_entered_finish_line():
	transitioningOut.emit()
	await get_tree().create_timer(0.5).timeout
	player.global_position = playerSpawnPoint.global_position
	transitioningIn.emit()
	await get_tree().create_timer(0.5).timeout
	var temp = preload("res://Modifiers/DoubleJumpHeight/Mod_DoubleJumpHeight.tscn").instantiate()
	add_child(temp)
	var temp2 = preload("res://Modifiers/InvertedWalking/Mod_InvertedWalking.tscn").instantiate()
	add_child(temp2)
