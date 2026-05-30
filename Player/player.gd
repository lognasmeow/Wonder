extends CharacterBody3D

const SPEED = 12.0
const JUMP_VELOCITY = 15

signal enteredFallPlane
signal enteredFinishLine

func _physics_process(delta):
	addGravity(delta)
	handleJump()
	handleMove()
	move_and_slide()

func addGravity(delta: float) -> void:
	if not is_on_floor():
		velocity += (get_gravity() * 4) * delta

func handleJump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = (JUMP_VELOCITY * Modifiers.jumpHeightMultiplier)

func handleMove() -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down") \
					if not Modifiers.invertedWalking \
					else Input.get_vector("right", "left", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if (is_on_floor()):
			velocity.x = lerp(velocity.x, direction.x * SPEED, Modifiers.floorIciness) 
			velocity.z = lerp(velocity.z, direction.z * SPEED, Modifiers.floorIciness)
	else:
		if (is_on_floor()):
			velocity.x = lerp(velocity.x, move_toward(velocity.x, 0, SPEED), Modifiers.floorIciness)
			velocity.z = lerp(velocity.z, move_toward(velocity.z, 0, SPEED), Modifiers.floorIciness)


func _on_fall_plane_body_entered(body):
	if (body.name == "Player"):
		enteredFallPlane.emit()


func _on_area_finish_line_body_entered(body):
	if (body.name == "Player"):
		enteredFinishLine.emit()
