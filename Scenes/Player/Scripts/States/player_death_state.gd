extends State
class_name die_state

@onready var sprite = $"../../AnimatedSprite2D"

func Enter():
	sprite.play("Death")
	pass

