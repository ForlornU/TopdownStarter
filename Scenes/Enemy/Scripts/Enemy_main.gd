extends CharacterBody2D

@onready var fsm = $FSM as FiniteStateMachine
@onready var sprite = $AnimatedSprite2D
var PlayerInRange = false

func _ready():
	pass

func _physics_process(delta):
	Turn()

func Turn():
	#Moving left or right	
	#Fun fact, this sprite is flipped the wrong way, values are inverted
	if(velocity.x < 0):
		sprite.flip_h = false
	elif(velocity.x > 0):
		sprite.flip_h = true

func finished_attacking():
	print("Done attacking, switching states")
	if(PlayerInRange == true):
		#fsm.change_state(enemy_attack_state, "enemy_chase_state")
		fsm.force_change_state("enemy_chase_state")
	else:
		#fsm.change_state(enemy_attack_state, "enemy_idle_state")
		fsm.force_change_state("enemy_idle_state")

func _on_detection_area_body_entered(body):
	print(body.name)
	if body.is_in_group("Player"):
		PlayerInRange = true
		if fsm.current_state.name == "enemy_idle_state" or fsm.current_state == enemy_idle_state:
			fsm.force_change_state("enemy_chase_state")

func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		PlayerInRange = false
