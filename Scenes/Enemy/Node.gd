extends State

@onready var sprite = $"../../AnimatedSprite2D"

func Enter():
	sprite.play("Death")
	pass

