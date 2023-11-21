extends State
class_name PlayerWalking

@export var movespeed := int(350)
var dashspeed := int(100)
@export var dashMax := int(500)

var canDash := bool(false)
var dashDir := Vector2(0,0)

var player : CharacterBody2D
@export var player_sprite : AnimatedSprite2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	player_sprite.play("Walk")
	pass

func Update(delta : float):
	Move()
	LessenDash(delta)

	if(Input.is_action_just_pressed("Dash") && canDash):
		dashspeed = dashMax
		dashDir = player.velocity.normalized()
		player_sprite.play("Dash")
		canDash = false
		
	if Input.is_action_just_pressed("Attack"):
		Transition("Attacking")
	
func Move():
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	
	#Suddenly turning mid dash
	if(dashDir != Vector2.ZERO and dashDir != input_dir):
		dashDir = Vector2.ZERO
		dashspeed = 0
		print("Turned mid-dash")
		
	player.velocity = input_dir * movespeed + dashDir * dashspeed 
	player.move_and_slide()

	if(input_dir.length() <= 0):
		Transition("Idle")


func LessenDash(delta):
	#Higher multiplier values makes the dash shorter
	var multiplier = 4
	var timemultiplier := float(4)
	
	#slow down the dash over time, both with a multiplier of dashspeed and also time
	dashspeed -= (dashspeed * multiplier * delta) + (delta * timemultiplier)
	dashspeed = clamp(dashspeed, 0, dashMax)
	
	if(dashspeed <= 0):
		canDash = true
		dashDir = Vector2.ZERO
		
	if(player_sprite.animation == "Dash"):
		await player_sprite.animation_finished
		player_sprite.play("Walk")

func Transition(newstate):
	if(dashspeed <= 0):
		state_transition.emit(self, newstate)
