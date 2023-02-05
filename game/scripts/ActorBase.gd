extends KinematicBody2D
class_name ActorBase

export var velocity = Vector2(0, 0)
export var gravity = Vector2(0, 0)
	
func _physics_process(delta: float) -> void:
	velocity += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
