extends Control

@onready var vbox: VBoxContainer = $VBoxContainer
@onready var bgm: AudioStreamPlayer = $bgm
@onready var credits: Control = $Credits

func _ready():
	bgm.play()
	vbox.get_child(0).grab_focus()


func _on_btn_play_pressed():
	if !credits.visible:		#hacky solution because no time
		get_tree().change_scene_to_file("res://Maps/map_main.tscn")


func _on_btn_credits_pressed():
	credits.visible = true


func _on_btn_quit_pressed():
	if !credits.visible:		#hacky solution because no time
		get_tree().quit()


func _on_credits_exiting_credits():
	credits.visible = false
