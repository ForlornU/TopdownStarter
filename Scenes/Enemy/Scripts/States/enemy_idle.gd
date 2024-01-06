extends State
class_name enemy_idle_state

@export var animator : AnimationPlayer

func Enter():
	animator.play("Idle")
	pass

func Update(_delta):
	pass
