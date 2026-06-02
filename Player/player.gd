extends CharacterBody3D

@onready var timerSpeedBoost: Timer = $timerSpeedBoost
@onready var cameraPivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/SpringArm3D/Camera3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouseSensitivity: float = 0.15
var cameraInputDirection: Vector2 = Vector2.ZERO

const SPEED = 12.0
const JUMP_VELOCITY = 15

var speedMultiplier: float = 1.0

signal enteredFallPlane
signal enteredFinishLine

func _ready():
	connectModifierSignals()

func connectModifierSignals() -> void:
	EventBus.speedBoostTouched.connect(_on_speed_boost_touched)
	EventBus.playerSquished.connect(_on_player_squished)

func _physics_process(delta):
	addGravity(delta)
	handleJump()
	handleMove()
	handleCameraMovement(delta)
	move_and_slide()
	
func _input(event):
	if (event is InputEventMouseMotion):
		getCameraInputDirection(event)
	
#region Camera
func getCameraInputDirection(event: InputEvent) -> void:
	cameraInputDirection = event.screen_relative * mouseSensitivity
	
func handleCameraMovement(delta: float) -> void:
	#cameraPivot.rotation.x += cameraInputDirection.y * delta
	#cameraPivot.rotation.x = clamp(cameraPivot.rotation.x, deg_to_rad(-40), deg_to_rad(10))
	
	cameraPivot.rotation.y -= cameraInputDirection.x * delta
	
	cameraInputDirection = Vector2.ZERO
#endregion

#region Movement
func addGravity(delta: float) -> void:
	if not is_on_floor():
		velocity += ((get_gravity() * 4) * Modifiers.gravityMultiplier) * delta
		
func handleJump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = (JUMP_VELOCITY * Modifiers.jumpHeightMultiplier)

func handleMove() -> void:
	var direction: Vector3 = getMovementDirection()
	
	if direction:
		if (is_on_floor()):
			velocity.x = lerp(velocity.x, direction.x * (SPEED * speedMultiplier), Modifiers.floorIciness) 
			velocity.z = lerp(velocity.z, direction.z * (SPEED * speedMultiplier), Modifiers.floorIciness)
	else:
		if (is_on_floor()):
			velocity.x = lerp(velocity.x, move_toward(velocity.x, 0, (SPEED * speedMultiplier)), Modifiers.floorIciness)
			velocity.z = lerp(velocity.z, move_toward(velocity.z, 0, (SPEED * speedMultiplier)), Modifiers.floorIciness)
			
func getMovementDirection() -> Vector3:
	var input_dir = Input.get_vector("left", "right", "up", "down") \
					if not Modifiers.invertedWalking \
					else Input.get_vector("right", "left", "up", "down")
	var cameraRelativeForward: Vector3 = camera.global_basis.z
	var cameraRelativeRight: Vector3 = camera.global_basis.x				
	
	var direction = (cameraRelativeForward * input_dir.y + cameraRelativeRight * input_dir.x)
	direction.y = 0.0
	return direction.normalized()
#endregion


func _on_fall_plane_body_entered(body):
	if (body.name == "Player"):
		enteredFallPlane.emit()

func _on_area_finish_line_body_entered(body):
	if (body.name == "Player"):
		enteredFinishLine.emit()
		
func _on_speed_boost_touched():
	speedMultiplier = 2.0
	timerSpeedBoost.start()

func _on_timer_speed_boost_timeout():
	speedMultiplier = 1.0
	
func _on_player_squished():
	enteredFallPlane.emit()
