extends ActorBase

export var direction = 1

func _init() -> void:
	self.set_meta('type', 'enemy')

func _process(delta: float) -> void:
	
	if is_on_wall():
		direction *= -1
	
	if direction == 1:
		velocity.x = 100
		$AnimatedSprite.flip_h = false
	elif direction == -1:
		velocity.x = -100
		$AnimatedSprite.flip_h = true
	else:
		print_debug("wtf")
	

func damage_or_kill(player: Player):
	var d = player.position - position
	if d.sign().x != direction:
		queue_free()
		return true
	else:
		return false

func on_kill():
	pass
