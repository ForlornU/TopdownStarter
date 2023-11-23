extends CharacterBody2D
class_name CharacterBase

@export var sprite : AnimatedSprite2D
@export var healthbar : ProgressBar
@export var health : int
@export var flipped_horizontal : bool

func _ready():
	init_character()
	
func _process(delta):
	Turn()
	
func init_character():
	healthbar.max_value = health
	healthbar.value = health

func Turn():
	var direction = -1 if flipped_horizontal == true else 1
	
	if(velocity.x < 0):
		sprite.scale.x = -direction
	elif(velocity.x > 0):
		sprite.scale.x = direction
	
func _take_damage(amount):
	health -= amount
	healthbar.value = health;
	if(health <= 0):
		_die()
		print("Character died")
		await get_tree().create_timer(1.0).timeout
		queue_free()
	
func _die():
	pass
	
func ConnectForDamage(node):
	node.DealDamage.connect(_take_damage)

