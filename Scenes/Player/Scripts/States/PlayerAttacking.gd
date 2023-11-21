extends State
class_name PlayerAttacking

@export var sprite : AnimatedSprite2D

var has_dealt_damage = false
@export var damage = 50
signal DealDamage

@onready var hitbox = $"../../AnimatedSprite2D/Hitbox/hitboxShape"


func Enter():
	has_dealt_damage = false
	hitbox.disabled = false
	
	sprite.play("Attack")
	
	await sprite.animation_finished
	state_transition.emit(self, "Idle")

func Exit():
	has_dealt_damage = false
	hitbox.disabled = true
	
func Update(delta):
	if sprite.frame == 3 || sprite.frame == 4: #Damage frames
		if has_dealt_damage == false:
			hitbox.disabled = false
	else:
		hitbox.disabled = true

func _on_hitbox_body_entered(body):
	print(body)
	if body.is_in_group("Enemy") and has_dealt_damage == false:
		var enemy = body as EnemyMain
		deal_damage(enemy)

func deal_damage(enemy):
	enemy.ConnectToPlayer(self)
	emit_signal("DealDamage", damage)
	has_dealt_damage = true