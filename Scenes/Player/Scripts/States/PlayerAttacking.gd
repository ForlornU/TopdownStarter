extends State
class_name PlayerAttacking

@export var sprite : AnimatedSprite2D

var has_dealt_damage = false
@export var damage = 50
signal DealDamage

@onready var hitbox = $"../../AnimatedSprite2D/Hitbox/hitboxShape"
@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"

func Enter():
	has_dealt_damage = false
	hitbox.disabled = false
	AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.25, 1)
	
	sprite.play("Attack")
	
	await sprite.animation_finished
	state_transition.emit(self, "Idle")

func Exit():
	has_dealt_damage = false
	hitbox.disabled = true
	
func Update(_delta):
	if sprite.frame == 3 || sprite.frame == 4: #Damage frames
		if has_dealt_damage == false:
			hitbox.disabled = false
	else:
		hitbox.disabled = true

func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy") and has_dealt_damage == false:
		var enemy = body as EnemyMain
		deal_damage(enemy)
		#AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 0, 1)

func deal_damage(enemy):
	hit_particles.emitting = true
	enemy.ConnectForDamage(self)
	emit_signal("DealDamage", damage)
	has_dealt_damage = true
