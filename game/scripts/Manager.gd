extends Node2D
class_name Manager

export (PackedScene) var enemy_scene

var i = 0
onready var state = $State

signal hp_changed(value)
signal score_changed(value)

func _on_hp_changed(delta: int) -> void:
	if state.hp + delta > state.max_hp:
		state.hp = state.max_hp
	elif state.hp + delta < 0:
		state.hp = 0
	else:
		state.hp += delta
	
	emit_signal('hp_changed', state.hp)

func _on_enemy_killed(level: int):
	state.score += level
	emit_signal('score_changed', state.score)

func spawn_enemy(level: int):
	var enemy = enemy_scene.instance()
	enemy.variant = level
	enemy.gravity.y = 180
	enemy.position = Vector2(rand_range(150, 900), -8)
	enemy.connect("enemy_killed", self, "_on_enemy_killed")
	add_child(enemy)

func spawn_wave():
	for delay in range(10):
		var timer = get_tree().create_timer(delay)
		timer.connect("timeout", self, "spawn_enemy", [floor(randf() * 3) + 1])

func _ready() -> void:
	$intro.play()
	spawn_wave()
	
func _on_intro_finished():
	$main_mus.play()
	
