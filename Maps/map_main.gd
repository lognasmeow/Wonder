extends Node3D

@onready var playerSpawnPoint = $Marker3D_PlayerSpawn
@onready var player = $Player
@onready var objectCorner1: Marker3D = $ObjectRegion/Marker_ObjectCorner1
@onready var objectCorner2: Marker3D = $ObjectRegion/Marker_ObjectCorner2

signal transitioningOut
signal transitioningIn

func _ready():
	connectModifierSignals()
	player.global_position = playerSpawnPoint.global_position
	transitioningIn.emit()
	await get_tree().create_timer(0.5).timeout
	
func _input(event):
	if (event.is_action_pressed("ui_cancel")):
		if (!get_tree().paused):
			pauseGame()	
	
func pauseGame() -> void:
	get_tree().paused = true

func unpauseGame() -> void:
	get_tree().paused = false
	
func connectModifierSignals() -> void:
	EventBus.modifierAdded.connect(_on_modifier_added)
	EventBus.spikesModifierAdded.connect(_on_spikes_modifier_added)
	
func spawnObjects(objectPath: String, amountToSpawn: int, scaleModifier: float, yOffset: float) -> void:
	var objectToSpawn = load(objectPath)
	for i in range(amountToSpawn):
		var instantiatedObject = objectToSpawn.instantiate()
		add_child(instantiatedObject)
		
		var randomXLocation: float = randf_range(objectCorner1.global_position.x, objectCorner2.global_position.x)
		var randomZLocation: float = randf_range(objectCorner1.global_position.z, objectCorner2.global_position.z)
		var yLocation: float = playerSpawnPoint.global_position.y + yOffset
		instantiatedObject.global_position = Vector3(randomXLocation, yLocation, randomZLocation)
		
		var randomScaleAmount: float = randf_range(1.0, scaleModifier)
		instantiatedObject.scale.x = randomScaleAmount
		instantiatedObject.scale.y = randomScaleAmount
		instantiatedObject.scale.z = randomScaleAmount
		
		instantiatedObject.rotation.y = deg_to_rad(randf_range(0.0, 360.0))


func _on_player_entered_fall_plane():
	transitioningOut.emit()
	await get_tree().create_timer(1.0).timeout
	Modifiers.resetModifiers()
	Modifiers.resetModifierPaths()
	get_tree().reload_current_scene()


func _on_player_entered_finish_line():
	transitioningOut.emit()
	await get_tree().create_timer(1.0).timeout
	player.global_position = playerSpawnPoint.global_position
	transitioningIn.emit()
	await get_tree().create_timer(1.0).timeout
	applyRandomModifier()
	
func _on_modifier_added(objectPath: String, amountToSpawn: int, scaleModifier: float, yOffset: float):
	spawnObjects(objectPath, amountToSpawn, scaleModifier, yOffset)	

func applyRandomModifier() -> void:
	if (Modifiers.modifierPaths.size() > 0):
		var randValue: int = randi_range(0, Modifiers.modifierPaths.size() - 1)
		var randModifierPath: String = Modifiers.modifierPaths[randValue]
		var modifier = load(randModifierPath).instantiate()
		add_child(modifier)
		Modifiers.modifierPaths.remove_at(randValue)


func _on_fall_plane_body_entered(body):
	if body.is_in_group("ModifierObject"):
		body.queue_free()

func _on_spikes_modifier_added():
	get_node("ModSpikes").squish()
