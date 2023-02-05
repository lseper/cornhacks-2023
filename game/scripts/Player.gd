extends ActorBase
class_name Player

signal _hp_changed(delta)

export var speed = 160
var direction = 1

func _process(delta: float) -> void:
	var movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if movement < -0.25:
		direction = -1
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
		$Laptop.reset_pos.x = -50
	elif movement > 0.25:
		direction = 1
		velocity.x = speed
		$AnimatedSprite.flip_h = false
		$Laptop.reset_pos.x = 0
		
	var collision = get_last_slide_collision()
	if is_instance_valid(collision) and is_instance_valid(collision.collider):
		if collision.collider.has_method("get_damage"):
			var damage = collision.collider.get_damage()
			emit_signal("_hp_changed", damage)
	
