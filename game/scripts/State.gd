extends Node

export var hp = 100
export var max_hp = 100

signal hp_changed(value)

func _on_hp_changed(delta: int) -> void:
	if hp + delta > max_hp:
		hp = max_hp
	elif hp + delta < 0:
		hp = 0
	else:
		hp -= delta
	
	emit_signal('hp_changed', hp)
