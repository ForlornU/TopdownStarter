extends State
class_name enemy_attack_state

var has_dealt_damage

@onready var enemy = $"../.."
@onready var sprite = $"../../AnimatedSprite2D"
@onready var HitBox = $"../../HitBox/CollisionShape2D"

func Enter():
	has_dealt_damage = false
	HitBox.disabled = true
	
	sprite.play("Attack")
	await sprite.animation_finished
	enemy.finished_attacking()
	
	
func Exit():
	has_dealt_damage = false
	HitBox.disabled = true
	
func Update(delta):
	if sprite.frame == 3 || sprite.frame == 4: #Damage frames
		if has_dealt_damage == false:
			HitBox.disabled = false
	else:
		HitBox.disabled = true

func _on_hit_box_body_entered(body):
	if body.is_in_group("Player") and has_dealt_damage == false:
		has_dealt_damage = true
		print("hit")

