extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$VideoPlayer.play()
	# wait 35 seconds
	yield(get_tree().create_timer(34), "timeout")
	$AnimationPlayer.play("Fade Out")
	yield(get_tree().create_timer(1), "timeout")
	$VideoPlayer.hide()
	$AudioStreamPlayer.play()
	
	
	$AnimationPlayer.play("RESET")
	$"coding heroes".show()
	yield(get_tree().create_timer(3), "timeout")
	$AnimationPlayer.play("Fade Out")
	yield(get_tree().create_timer(1), "timeout")
	
	$AnimationPlayer.play("RESET")
	$"music master".show()
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("Fade Out")
	yield(get_tree().create_timer(1), "timeout")
	$"music master".hide()
	
	$AnimationPlayer.play("RESET")
	$"art guru".show()
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("Fade Out")
	yield(get_tree().create_timer(1), "timeout")
	$"art guru".hide()
	
	$AnimationPlayer.play("RESET")
	$"presented".show()
	yield(get_tree().create_timer(2.66), "timeout")
	$AnimationPlayer.play("Fade Out")
	yield(get_tree().create_timer(1), "timeout")
	$"presented".hide()
	
	# switch scenes here
	get_tree().change_scene("res://scenes/menu.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/menu.tscn")
