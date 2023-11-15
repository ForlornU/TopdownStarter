extends State
class_name PlayerAttacking

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("Attack")
	await sprite.animation_finished
	state_transition.emit(self, "Idle")

func Exit():
	pass


