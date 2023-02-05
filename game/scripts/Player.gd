extends ActorBase
class_name Player

export var speed = 160
var direction = 1

var laptop_position = Vector2(25, 0)

func _process(delta: float) -> void:
	var movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if movement < -0.5:
		direction = -1
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
		$Laptop.transform.x = -25.0
	elif movement > 0.5:
		direction = 1
		velocity.x = speed
		$AnimatedSprite.flip_h = false
		$Laptop.transform.x = 25.0
	
