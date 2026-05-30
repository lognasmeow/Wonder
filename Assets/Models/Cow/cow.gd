extends Node3D

@onready var audioStreamPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _on_area_3d_body_entered(body):
	if (body.name == "Player"):
		audioStreamPlayer.play()
