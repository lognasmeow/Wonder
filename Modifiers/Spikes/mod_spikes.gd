extends Node3D

@onready var spikesLeft: Node3D = $Spikes
@onready var spikesRight: Node3D = $Spikes2

var squishing: bool = false
var squishSpeed: float = 0.01

func _ready():
	EventBus.modifierAdded.connect(_on_spikes_reload)
	EventBus.spikesModifierAdded.emit()
	squishing = true
	
func _process(_delta):
	if (!squishing):
		return
	
	if (spikesLeft.position.x < -2 and spikesRight.position.x > 2):
		spikesLeft.position.x += squishSpeed
		spikesRight.position.x -= squishSpeed

func squish():
	squishing = true


func _on_area_3d_left_body_entered(body):
	collisionOccurred(body)


func _on_area_3d_right_body_entered(body):
	collisionOccurred(body)
	
func _on_spikes_reload():
	get_tree().reload_current_scene()

func collisionOccurred(body) -> void:
	if (body.name == "Player"):
		EventBus.playerSquished.emit()
