extends State
class_name PlayerIdle

@export var animator : AnimationPlayer

func Enter():
	animator.play("Idle")
	pass
	
func Update(_delta : float):
	if(Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()):
		state_transition.emit(self, "Moving")
		
	if Input.is_action_just_pressed("Punch")  or Input.is_action_just_pressed("Kick"):
		state_transition.emit(self, "Attacking")
