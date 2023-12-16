extends State
class_name die_state

@export var animator : AnimationPlayer

func Enter():
	animator.play("Death")

