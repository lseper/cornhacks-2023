extends KinematicBody2D

func _process(delta: float) -> void:
	position = Vector2(0, 0)
	
	var collision = move_and_collide(Vector2(0, 0))
	
	if is_instance_valid(collision) and is_instance_valid(collision.collider):
		if collision.collider.has_method("deal_damage"):
			collision.collider.deal_damage()
