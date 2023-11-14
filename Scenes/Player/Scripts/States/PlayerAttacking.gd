extends State
class_name PlayerAttacking

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("Attack")
	pass
	
func Exit():
	pass
	
func Update(delta : float):
	if sprite.is_playing() and sprite.animation == "Attack":
		await sprite.animation_looped
		state_transition.emit(self, "Idle")

