extends Control

@onready var vbox: VBoxContainer = $VBoxContainer

signal resumePressed

func _ready():
	vbox.get_child(0).grab_focus()


func _on_map_main_pausing():
	vbox.get_child(0).grab_focus()


func _on_btn_resume_pressed():
	resumePressed.emit()


func _on_btn_quit_pressed():
	get_tree().quit()
