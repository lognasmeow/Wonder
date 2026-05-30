extends CanvasLayer

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func fadeOut() -> void:
	animationPlayer.play("fadeOut")
	await animationPlayer.animation_finished
	
func fadeIn() -> void:
	animationPlayer.play("fadeIn")
	await animationPlayer.animation_finished


func _on_map_main_transitioning_out():
	fadeOut()


func _on_map_main_transitioning_in():
	fadeIn()
