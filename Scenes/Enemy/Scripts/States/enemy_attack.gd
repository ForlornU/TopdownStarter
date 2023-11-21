extends State
class_name enemy_attack_state

var has_dealt_damage
signal DealDamage
@export var damage = 25

@onready var enemy = $"../.."
@onready var sprite = $"../../AnimatedSprite2D"
@onready var HitBox = $"../../AnimatedSprite2D/HitBox/CollisionShape2D"

func Enter():
	has_dealt_damage = false
	HitBox.disabled = true

	sprite.play("Attack")
	await sprite.animation_finished
	enemy.finished_attacking()
	
func Exit():
	has_dealt_damage = false
	HitBox.disabled = true
	
func Update(_delta):
	if sprite.frame == 3 || sprite.frame == 4: #Damage frames
		if has_dealt_damage == false:
			HitBox.disabled = false
	else:
		HitBox.disabled = true

#During attack animation, Hitbox is activated and tries to find the player
func _on_hit_box_body_entered(body):
	if body.is_in_group("Player") and has_dealt_damage == false:
		var player = body as PlayerMain
		deal_damage_to_player(player)

#Connect and deal damage to the player
func deal_damage_to_player(player):
		player.ConnectToEnemy(self)
		emit_signal("DealDamage", damage)
		has_dealt_damage = true


