extends State
class_name PlayerWalking

@export var movespeed := int(350)

var dashspeed := int(100)
@export var dash_max := int(500)
var can_dash := bool(false)
var dash_direction := Vector2(0,0)

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

	if(Input.is_action_just_pressed("Dash") && can_dash):
		start_dash(input_dir)
		
	if Input.is_action_just_pressed("Attack"):
		Transition("Attacking")
	
func Move(input_dir):
	#Suddenly turning mid dash
	if(dash_direction != Vector2.ZERO and dash_direction != input_dir):
		dash_direction = Vector2.ZERO
		dashspeed = 0

	player.velocity = input_dir * movespeed + dash_direction * dashspeed 
	player.move_and_slide()

	if(input_dir.length() <= 0):
		Transition("Idle")

func start_dash(input_dir):
	dash_direction = input_dir.normalized()
	dashspeed = dash_max
	player_sprite.play("Dash")
	can_dash = false

func LessenDash(delta):
	#Higher multiplier values makes the dash shorter
	var multiplier = 4.0
	var timemultiplier = 4.1
	
	#slow down the dash over time, both as a fraction of dashspeed and also time
	#While clamping it between 0 and dash_max
	dashspeed -= (dashspeed * multiplier * delta) + (delta * timemultiplier)
	dashspeed = clamp(dashspeed, 0, dash_max)
	
	if(dashspeed <= 0):
		can_dash = true
		dash_direction = Vector2.ZERO
		
	if(player_sprite.animation == "Dash"):
		await player_sprite.animation_finished
		player_sprite.play("Walk")

#We cannot allow a transition before the dash is complete and the animation has stopped playing
func Transition(newstate):
	if(dashspeed <= 0):
		state_transition.emit(self, newstate)
