extends RichTextLabel

var score = 0
var hp = 100

func update_label():
	text = "Score: " + str(score) + "\n" + "HP: " + str(hp)

func _on_hp_changed(val: int) -> void:
	hp = val
	update_label()

func _on_score_changed(val: int) -> void:
	score = val
	update_label()

func _ready():
	update_label()
