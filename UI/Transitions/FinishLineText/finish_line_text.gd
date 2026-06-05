extends Control

@onready var richTextLabel: RichTextLabel = $RichTextLabel

var moveText: bool = false

func _ready():
	resetTextPosition()

func _process(_delta):
	if (moveText):
		richTextLabel.position.x -= 4
	if richTextLabel.position.x < -999:
		resetTextPosition()
		moveText = false

func resetTextPosition() -> void:
	richTextLabel.position.x = 600
