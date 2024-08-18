extends State
class_name enemy_chase_state

@export var attack_range := float(50)
@export var move_speed := float(30)

@export var animator : AnimationPlayer
@onready var body = $"../.."

func Enter():
	animator.play("Chasing")

func Update(_delta):
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	var chase_direction = player.position - body.position as Vector2

	body.velocity = chase_direction.normalized() * move_speed
	body.move_and_slide()
	
	if(chase_direction.length() <= attack_range):
		state_transition.emit(self, "enemy_attack_state")
		
