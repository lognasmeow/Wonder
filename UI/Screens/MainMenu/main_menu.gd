extends Control

@onready var vbox: VBoxContainer = $VBoxContainer

func _ready():
	vbox.get_child(0).grab_focus()


func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://Maps/map_main.tscn")


func _on_btn_credits_pressed():
	pass # Replace with function body.


func _on_btn_quit_pressed():
	get_tree().quit()
