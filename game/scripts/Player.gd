extends ActorBase
class_name Player

signal hp_changed(delta)

export var speed = 160
var direction = 1
var invuln = false

func make_vulnerable():
	invuln = false

func _physics_process(_delta: float) -> void:
	$Ass.move_and_slide(Vector2(0, 0), Vector2.UP)

func _process(_delta: float) -> void:
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
		
	var collision = $Ass.get_last_slide_collision()

	if is_instance_valid(collision) and is_instance_valid(collision.collider):
		if collision.collider.has_method("get_damage") and not invuln:
			var damage = collision.collider.get_damage()
			invuln = true
			get_tree().create_timer(0.5).connect("timeout", self, "make_vulnerable")
			emit_signal("hp_changed", -damage)
