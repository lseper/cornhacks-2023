extends KinematicBody2D

var reset_pos = Vector2(0, 0)

func _process(delta: float) -> void:
	position = reset_pos
	var collision = move_and_collide(Vector2(0, 0))
	
	if is_instance_valid(collision) and is_instance_valid(collision.collider):
		if collision.collider.has_method("deal_damage"):
			collision.collider.deal_damage()
