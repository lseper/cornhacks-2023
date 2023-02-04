extends ActorBase
class_name Player

export var speed = 160
var direction = 1

func _process(delta: float) -> void:
	var movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if movement < -0.5:
		direction = -1
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
	elif movement > 0.5:
		direction = 1
		velocity.x = speed
		$AnimatedSprite.flip_h = false
		
	var collision = get_last_slide_collision()
	if is_instance_valid(collision):
		if is_instance_valid(collision.collider):
			if collision.collider.has_method('damage_or_kill'):
				collision.collider.damage_or_kill(self)
