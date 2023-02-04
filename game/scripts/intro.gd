extends Node2D

var CorrectSound = preload("res://sounds/itk.ogg")

func _process(delta: float) -> void:
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = CorrectSound
		$AudioStreamPlayer.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

