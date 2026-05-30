extends Node3D

@onready var playerSpawnPoint = $Marker3D_PlayerSpawn
@onready var player = $Player

signal transitioningOut
signal transitioningIn

func _ready():
	player.global_position = playerSpawnPoint.global_position


func _on_player_entered_fall_plane():
	transitioningOut.emit()
	await get_tree().create_timer(0.5).timeout
	player.global_position = playerSpawnPoint.global_position
	transitioningIn.emit()
	await get_tree().create_timer(0.5).timeout


func _on_player_entered_finish_line():
	transitioningOut.emit()
	await get_tree().create_timer(0.5).timeout
	player.global_position = playerSpawnPoint.global_position
	transitioningIn.emit()
	await get_tree().create_timer(0.5).timeout
