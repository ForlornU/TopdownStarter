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
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	
	Move(input_dir)
	LessenDash(delta)

	if(Input.is_action_just_pressed("Dash") && canDash):
		start_dash(input_dir)
		
	if Input.is_action_just_pressed("Attack"):
		Transition("Attacking")
	
func Move(input_dir):
	#Suddenly turning mid dash
	if(dashDir != Vector2.ZERO and dashDir != input_dir):
		dashDir = Vector2.ZERO
		dashspeed = 0

	player.velocity = input_dir * movespeed + dashDir * dashspeed 
	player.move_and_slide()

	if(input_dir.length() <= 0):
		Transition("Idle")

func start_dash(input_dir):
	dashDir = input_dir.normalized()
	dashspeed = dashMax
	player_sprite.play("Dash")
	canDash = false

func LessenDash(delta):
	#Higher multiplier values makes the dash shorter
	var multiplier = 4.0
	var timemultiplier = 4.1
	
	#slow down the dash over time, both as a fraction of dashspeed and also time
	#While clamping it between 0 and dashMax
	dashspeed -= (dashspeed * multiplier * delta) + (delta * timemultiplier)
	dashspeed = clamp(dashspeed, 0, dashMax)
	
	if(dashspeed <= 0):
		canDash = true
		dashDir = Vector2.ZERO
		
	if(player_sprite.animation == "Dash"):
		await player_sprite.animation_finished
		player_sprite.play("Walk")

#We cannot allow a transition before the dash is complete and the animation has stopped playing
func Transition(newstate):
	if(dashspeed <= 0):
		state_transition.emit(self, newstate)
