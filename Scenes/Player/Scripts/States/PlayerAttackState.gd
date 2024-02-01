extends State
class_name PlayerAttacking

@export var animator : AnimationPlayer
var current_attack : Attack_Data
@export var attacks : Array[Attack_Data]
@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"

func Enter():
	AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.3, 1)
	
	#Play the attack animation and wait for it to finish, transition from this state is handled by the animation player
	DetermineAttack()
	animator.play(current_attack.anim)
	await animator.animation_finished
	state_transition.emit(self, "Idle")

#Read which attack to use from our two attack nodes
func DetermineAttack():
	if(Input.is_action_just_pressed("Punch")):
		current_attack = attacks[0]
	elif(Input.is_action_just_pressed("Kick")):
		current_attack = attacks[1]

#Hitbox is turned on/off through the animationplayer, it an enemy is standing inside of it once that happens they take damage
#Both hitboxes call back to this function through signals
func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		deal_damage(body)
		AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 0, 1)

func deal_damage(enemy : EnemyMain):
	hit_particles.emitting = true
	enemy._take_damage(current_attack.damage)
