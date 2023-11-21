extends State
class_name enemy_idle_state

@export var sprite : AnimatedSprite2D

func Enter():
	print("Entered idle state")
	sprite.play("Idle")
	pass

func Update(_delta):
	pass
