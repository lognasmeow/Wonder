extends CharacterBody3D

@onready var timerSpeedBoost: Timer = $timerSpeedBoost
@onready var cameraPivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/SpringArm3D/Camera3D
@onready var mainCharacterSkin: Node3D = $mainCharacterSkin
@onready var animationTree: AnimationTree = $mainCharacterSkin/AnimationTree

@onready var sfxJump: AudioStreamPlayer = $sfxJump
@onready var sfxDied1: AudioStreamPlayer = $sfxDied1
@onready var sfxDied2: AudioStreamPlayer = $sfxDied2
@onready var sfxVictory2: AudioStreamPlayer = $sfxVictory2
@onready var sfxVictory3: AudioStreamPlayer = $sfxVictory3


@export_group("Camera")
@export_range(0.0, 1.0) var mouseSensitivity: float = 0.15
var cameraInputDirection: Vector2 = Vector2.ZERO

const SPEED = 118.0
const JUMP_VELOCITY = 15

var speedMultiplier: float = 1.0
var walkAnimationCurrentBlendPosition: float = -1.0
var isJumping: bool = false

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
	#cameraPivot.rotation.x -= cameraInputDirection.y * delta
	#cameraPivot.rotation.x = clamp(cameraPivot.rotation.x, deg_to_rad(-40), deg_to_rad(10))
	
	if (Modifiers.invertedMouse):
		cameraPivot.rotation.y += cameraInputDirection.x * delta
		mainCharacterSkin.rotation.y += cameraInputDirection.x * delta
	else:
		cameraPivot.rotation.y -= cameraInputDirection.x * delta
		mainCharacterSkin.rotation.y -= cameraInputDirection.x * delta
	
	cameraInputDirection = Vector2.ZERO
#endregion

#region Movement
func addGravity(delta: float) -> void:
	if not is_on_floor():
		velocity += ((get_gravity() * 4) * Modifiers.gravityMultiplier) * delta
		
func handleJump() -> void:	
	handleLand()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		sfxJump.play()
		velocity.y = (JUMP_VELOCITY * Modifiers.jumpHeightMultiplier)
		animationTree.set("parameters/jump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		isJumping = true
	
func handleLand() -> void:
	if (isJumping and !animationTree.get("parameters/jump/active")):
		isJumping = false
		animationTree.set("parameters/land/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func handleMove() -> void:
	var direction: Vector3 = getMovementDirection()
	
	if direction:
		walkAnimationCurrentBlendPosition += 0.1
		walkAnimationCurrentBlendPosition = clamp(walkAnimationCurrentBlendPosition, -1.0, 1.0)
		if (is_on_floor()):
			animationTree.set("parameters/movement/blend_position", walkAnimationCurrentBlendPosition)
			velocity.x = lerp(velocity.x, direction.x * (SPEED * speedMultiplier), Modifiers.floorIciness) 
			velocity.z = lerp(velocity.z, direction.z * (SPEED * speedMultiplier), Modifiers.floorIciness)
	else:
		walkAnimationCurrentBlendPosition -= 0.1
		walkAnimationCurrentBlendPosition = clamp(walkAnimationCurrentBlendPosition, -1.0, 1.0)
		if (is_on_floor()):
			velocity.x = lerp(velocity.x, move_toward(velocity.x, 0, (SPEED * speedMultiplier)), Modifiers.floorIciness)
			velocity.z = lerp(velocity.z, move_toward(velocity.z, 0, (SPEED * speedMultiplier)), Modifiers.floorIciness)
		animationTree.set("parameters/movement/blend_position", walkAnimationCurrentBlendPosition)
			
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
		sfxDied1.play()
		sfxDied2.play()
		enteredFallPlane.emit()

func _on_area_finish_line_body_entered(body):
	if (body.name == "Player"):
		sfxVictory2.play()
		sfxVictory3.play()
		enteredFinishLine.emit()
		
func _on_speed_boost_touched():
	speedMultiplier = 2.0
	timerSpeedBoost.start()

func _on_timer_speed_boost_timeout():
	speedMultiplier = 1.0
	
func _on_player_squished():
	enteredFallPlane.emit()
