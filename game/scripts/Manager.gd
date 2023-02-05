extends Node2D

func spawn_wave():
	pass

func _ready() -> void:
	$AudioStreamPlayer.play()
	spawn_wave()
	
