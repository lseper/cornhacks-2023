extends Sprite

onready var tween_values = [10.0, -10.0]

func _ready():
	_start_tween()

func _start_tween():
	$Tween.interpolate_property(self, "rotation_degrees", tween_values[0], tween_values[1], 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_tween_completed(_object, _key):
	tween_values.invert()
	_start_tween()

