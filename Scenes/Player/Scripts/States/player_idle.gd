extends State
class_name PlayerIdle

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("Idle")
	pass
	
func Update(_delta : float):
	if(Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()):
		state_transition.emit(self, "Moving")
		
	if Input.is_action_just_pressed("Attack"):
		state_transition.emit(self, "Attacking")

