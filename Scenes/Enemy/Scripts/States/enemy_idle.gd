extends State
class_name enemy_idle_state

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("Idle")
	pass

func Update(_delta):
	pass
