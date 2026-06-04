extends Control

@onready var vbox: VBoxContainer = $VBoxContainer


func _ready():
	vbox.get_child(0).grab_focus()
