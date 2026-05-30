extends Node3D

@onready var playerSpawnPoint = $Marker3D_PlayerSpawn
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = playerSpawnPoint.global_position


func _on_player_entered_fall_plane():
	player.global_position = playerSpawnPoint.global_position


func _on_player_entered_finish_line():
	player.global_position = playerSpawnPoint.global_position
