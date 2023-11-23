extends Area2D

#TextBubble
var talking = false
@export var speech : Label
@export var line1 = []

#AreaSignal
func _on_body_entered(body):
		if body.is_in_group("Player") and not talking:
			talk_tween()
			speech.text = line1[randi() % line1.size()]

func talk_tween():
	talking = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.2)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)
	tween.tween_property(self, "scale", Vector2.ONE, 0.2)
	
func _on_body_exited(body):
	if body.is_in_group("Player") and talking:
		await get_tree().create_timer(1.0).timeout #Show the text for a minimum of 1s
		speech.text = "*murmur*"
		await get_tree().create_timer(2.0).timeout #Show "murmur" for 2s before going silent
		speech.text = ""
		talking = false
	
func _ready():
	speech.text = ""

