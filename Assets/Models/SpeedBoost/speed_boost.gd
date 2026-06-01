extends Node3D

@onready var mesh: MeshInstance3D = $Sketchfab_model/ARROW_fbx/RootNode/Plane/Plane_Material_0

var movementAmplitude: float = 0.05
var movementFrequency: float = 2.0
var initialY: float

func _ready():
	initialY = mesh.position.x

func _process(_delta):
	var verticalOffset = sin(Time.get_ticks_msec() * 0.001 * movementFrequency) * movementAmplitude
	mesh.position.x = initialY + verticalOffset
	mesh.rotation.x += 0.01


func _on_area_3d_body_entered(body):
	if (body.name == "Player"):
		EventBus.speedBoostTouched.emit()
