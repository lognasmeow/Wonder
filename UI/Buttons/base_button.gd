extends Button

@export var focusScale: Vector2 = Vector2(1.2, 1.2)
@export var animationDuration: float = 0.15

var defaultCustomMinimumSize: Vector2
var newCustomMinimumSize: Vector2

var tween: Tween

func _ready():
	defaultCustomMinimumSize = get("custom_minimum_size")
	newCustomMinimumSize.x = defaultCustomMinimumSize.x * 1.2
	newCustomMinimumSize.y = defaultCustomMinimumSize.y * 1.2

func _on_focus_entered():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "custom_minimum_size", newCustomMinimumSize, animationDuration)

func _on_focus_exited():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "custom_minimum_size", defaultCustomMinimumSize, animationDuration)
