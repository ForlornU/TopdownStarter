extends State

@export var animator : AnimationPlayer

func Enter():
	animator.play("Death")
	pass

