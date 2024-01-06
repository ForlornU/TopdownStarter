extends State
class_name PlayerAttacking

@export var animator : AnimationPlayer
var current_attack : Attack_Data
@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"

func Enter():
	AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.3, 1)
	
	#Play the attack animation and wait for it to finish, transition from this state is handled by the animation player
	DetermineAttack()
	animator.play(current_attack.anim.resource_name)
	await animator.animation_finished
	state_transition.emit(self, "Idle")

#With only two attacks, we can define them in code like this and have input decide which to perform
#If many different types of attacks existed, we might make nodes with @export Attack_Data, where
#we set the data on each attack on a node, and assign the nodes to this state
func DetermineAttack():
	var punch = Attack_Data.new()
	punch.anim = animator.get_animation("Attack")
	punch.damage = 60
	
	var kick = Attack_Data.new()
	kick.anim = animator.get_animation("MoonKick")
	kick.damage = 25
	
	if(Input.is_action_just_pressed("Punch")):
		current_attack = punch
	elif(Input.is_action_just_pressed("Kick")):
		current_attack = kick

#Hitbox is turned on/off through the animationplayer, it an enemy is standing inside of it once that happens they take damage
#Both hitboxes call back to this function through signals
func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		deal_damage(body)
		AudioManager.play_sound(AudioManager.PLAYER_ATTACK_HIT, 0, 1)

func deal_damage(enemy : EnemyMain):
	hit_particles.emitting = true
	enemy._take_damage(current_attack.damage)
