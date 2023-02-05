extends ActorBase

class_name Enemy

enum { LIVING, DYING, DEAD }

export var direction = 1
export var variant = 1

var anim_t: float = 0
var animation_scale = 1
var animation_curve = 0
var last = 0
var state = LIVING

signal enemy_killed(level)

onready var sprite = $Sprite

func start_animation():
	anim_t = 0
	last = 0
	sprite.play(str(variant))
	
func next(_delta: float):
	return 1

func _ready() -> void:
	start_animation()

func _process(delta: float) -> void:
	var speed = 160 + variant * 40

	if is_on_wall():
		direction *= -1
	
	if state == DYING:
		velocity = Vector2(0, 0)
		return
	
	if direction == 1:
		velocity.x = speed * next(delta)
		sprite.flip_h = false
	elif direction == -1:
		velocity.x = -speed * next(delta)
		sprite.flip_h = true
	else:
		print_debug("wtf")
	

func deal_damage():
	$SlimeDeathSound.play()
	$Collision.disabled = true
	state = DYING
	sprite.play(str(variant) + "_death")
	gravity = Vector2(0, 0)
	emit_signal("enemy_killed", variant)

func get_damage():
	return variant * 3

func _on_player_death() -> void:
	velocity = Vector2(0, 0)
	gravity = Vector2(0, 0)
	state = DYING
	sprite.playing = false

func _on_animation_finished() -> void:
	if state == DYING:
		state = DEAD
		queue_free()
	else:
		start_animation()
