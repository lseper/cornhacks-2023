extends Node2D
class_name Manager

export (PackedScene) var enemy_scene

var i = 0
onready var state = $State

signal hp_changed(value)
signal score_changed(value)
signal death

var waves = [
	[5, 2, 0, 3],
	[4, 4, 1, 2],
	[4, 6, 2, 2],
	[5, 6, 2, 2],
	[4, 6, 3, 1],
	[3, 8, 3, 1],
	[2, 8, 4, 0.5],
	[2, 7, 5, 0.5],
	[2, 6, 8, 0.25],
	[1, 6, 10, 0.25],
]

func _on_hp_changed(delta: int) -> void:
	if state.hp + delta > state.max_hp:
		state.hp = state.max_hp
	elif state.hp + delta < 0:
		state.hp = 0
	else:
		state.hp += delta
	
	emit_signal('hp_changed', state.hp)
	
	if state.hp == 0:
		$main_mus.play()
		$main_mus.playing = false
		$main_mus.stream_paused = true
		$main_mus.stop()
		$intro.play()
		$intro.playing = false
		$intro.stream_paused = true
		$intro.stop()
		$game_over.play()
		emit_signal('death')
		state.dead = true
		yield($game_over, "finished")
		get_tree().change_scene("res://scenes/menu.tscn")

func _on_enemy_killed(level: int):
	state.score += level
	emit_signal('score_changed', state.score)

func spawn_enemy(level: int):
	var enemy = enemy_scene.instance()
	enemy.variant = level
	enemy.gravity.y = 180
	enemy.position = Vector2(rand_range(150, 900), -8)
	enemy.connect("enemy_killed", self, "_on_enemy_killed")
	self.connect("death", enemy, "_on_player_death")
	add_child(enemy)

func spawn_waves():
	for wave in waves:
		var queue = []
		for j in range(3):
			for _k in range(wave[j]):
				queue.append(j)
		queue.shuffle()
		for j in queue:
			yield(get_tree().create_timer(wave[3]), "timeout")
			if state.dead:
				return
			spawn_enemy(j + 1)
		yield(get_tree().create_timer(2), "timeout")

func _ready() -> void:
	$intro.play()
	spawn_waves()
	
func _on_intro_finished():
	$main_mus.play()
	
