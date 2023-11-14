extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D

func _physics_process(delta):
	Turn()

func Turn():
	#Moving left or right	
	if(velocity.x < 0):
		player_sprite.flip_h = true
	elif(velocity.x > 0):
		player_sprite.flip_h = false


