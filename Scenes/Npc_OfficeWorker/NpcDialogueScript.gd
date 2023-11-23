extends Area2D

#TextBubble
var talking = false
@export var speech : Label
@export var line1 = []

#Movement
#var time_passed = 0
#var initial_position := Vector2.ZERO
#@export var amplitude := 4
#@export var frequency := 5

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
		await get_tree().create_timer(1.0).timeout
		speech.text = "*murmur*"
		await get_tree().create_timer(2.0).timeout
		speech.text = ""
		talking = false
	
#Movement
func _ready():
#	initial_position = position
	speech.text = ""
	randomize()

#func _process(delta):
	#body_hover(delta)

#func body_hover(delta):
#	time_passed += delta
	
#	var new_y = initial_position.y + amplitude * sin(frequency * time_passed)
#	position.y = new_y
