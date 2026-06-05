extends Control

@onready var textureRect: TextureRect = $Control/TextureRect
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Control/CanvasLayer/Label
@onready var lockInLabel: Label = $Control/CanvasLayer/Label2

var currentModifier: String

func _ready():
	resetTextPosition()
	playModifierAnimation()
	currentModifier = "Nothing"
	lockInLabel.text = "Lock in!"
	

func resetTextPosition() -> void:
	textureRect.position.x = 350
	label.position.x = 663	


func _on_map_main_transitioning_in():
	label.text = Modifiers.modifierNames.get(currentModifier)
	playModifierAnimation()
	
func playModifierAnimation():
	animationPlayer.play("moveToView")
	await get_tree().create_timer(2.0).timeout
	animationPlayer.play("moveOutOfView")
	await get_tree().create_timer(2.0).timeout
	resetTextPosition()
