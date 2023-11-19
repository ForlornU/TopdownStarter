extends CharacterBody2D

@onready var fsm = $FSM as FiniteStateMachine
@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D
var PlayerInRange = false

func _ready():
	pass

func _physics_process(delta):
	Turn()

func Turn():
	#Moving left or right, we flip the sprite to left or right
	#This enemy sprite is flipped the wrong way, values are inverted
	# We don't flip the sprite normally like we do on the player, instead we change the entire scale, which also moves our attack hit-box to the other side 
	if(velocity.x < 0):
		sprite.scale.x = 1
	elif(velocity.x > 0):
		sprite.scale.x = -1

func finished_attacking():
	if(PlayerInRange == true):
		fsm.change_state_by_string("enemy_attack_state", "enemy_chase_state");
	else:
		fsm.change_state_by_string("enemy_attack_state", "enemy_idle_state");

func _on_detection_area_body_entered(body):
	print(body.name)
	if body.is_in_group("Player"):
		PlayerInRange = true
		if fsm.current_state.name == "enemy_idle_state" or fsm.current_state == enemy_idle_state:
			fsm.force_change_state("enemy_chase_state")

func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		PlayerInRange = false
		#fsm.force_change_state("enemy_idle_state")	
		fsm.change_state_by_string("enemy_chase_state", "enemy_idle_state");
	
