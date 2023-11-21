extends State
class_name enemy_chase_state

@export var attackRange := float(50)
@export var moveSpeed := float(30)

@onready var sprite = $"../../AnimatedSprite2D"
@onready var body = $"../.."

func Enter():
	sprite.play("Walk")
	print("Entered chase state")

func Update(_delta):
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	var chase_direction = player.position - body.position as Vector2

	body.velocity = chase_direction.normalized() * moveSpeed
	body.move_and_slide()
	
	if(chase_direction.length() <= attackRange):
		state_transition.emit(self, "enemy_attack_state")
		
