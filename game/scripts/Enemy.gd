extends ActorBase

class_name Enemy

export var direction = 1
export var damage_value = 2
export var speed = 150
export var variant = 1

var anim_t: float = 0
var animation_scale = 1
var animation_curve = 0
var last = 0

func start_animation():
	anim_t = 0
	last = 0
	$Sprite.play(str(variant))
	
func next(delta: float):
	return 1

func _ready() -> void:
	start_animation()

func _process(delta: float) -> void:
	if is_on_wall():
		direction *= -1
	
	if direction == 1:
		velocity.x = speed * next(delta)
		$Sprite.flip_h = false
	elif direction == -1:
		velocity.x = -speed * next(delta)
		$Sprite.flip_h = true
	else:
		print_debug("wtf")
	

func deal_damage():
	queue_free()

func get_damage():
	return damage_value

func _on_animation_finished() -> void:
	start_animation()
