extends Node3D

@onready var timer: Timer = $Timer
@onready var audioMeow: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var spriteMeow: Sprite2D = $SpriteMunchy2

func _on_timer_timeout():
	spriteMeow.visible = true
	audioMeow.play()
	await get_tree().create_timer(0.4).timeout
	spriteMeow.visible = false
	timer.wait_time = randf_range(4.0, 14.0)
