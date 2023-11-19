extends CharacterBody2D
class_name PlayerMain

@onready var player_sprite = $AnimatedSprite2D
var health = 100
@onready var fsm = $FSM as FiniteStateMachine
@onready var healthbar = $ProgressBar

func _physics_process(delta):
	Turn()
	
func _ready():
	healthbar.value = health;

func Turn():
	if(velocity.x < 0):
		player_sprite.scale.x = -1
	elif(velocity.x > 0):
		player_sprite.scale.x = 1

func ConnectToEnemy(node):
	node.DealDamage.connect(TakeDamage)
	pass

func TakeDamage(amount):
	health -= amount
	healthbar.value = health;
	if(health <= 0):
		fsm.force_change_state("Die")
	

