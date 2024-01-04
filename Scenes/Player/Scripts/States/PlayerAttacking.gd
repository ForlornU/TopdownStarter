extends State
class_name PlayerAttacking

@export var animator : AnimationPlayer
var has_dealt_damage = false
@export var damage = 50
signal DealDamage
@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"

func Enter():
	has_dealt_damage = false
	AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.3, 1)
	
	#Play the attack animation and wait for it to finish, transition from this state is handled by the animation player
	animator.play("Attack")
	await animator.animation_finished
	state_transition.emit(self, "Idle")

#Hitbox is turned on/off through the animationplayer, it an enemy is standing inside of it once that happens they take damage
func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy") and has_dealt_damage == false:
		var enemy = body as EnemyMain
		deal_damage(enemy)
		AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 0, 1)

func deal_damage(enemy):
	hit_particles.emitting = true
	enemy.ConnectForDamage(self)
	emit_signal("DealDamage", damage)
	has_dealt_damage = true
