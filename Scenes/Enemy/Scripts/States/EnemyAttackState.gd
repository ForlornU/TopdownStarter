extends State
class_name enemy_attack_state

@export var attack : Attack_Data
@onready var enemy = $"../.."
@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"
@export var animator : AnimationPlayer

func Enter():
	animator.play(attack.anim)
	await animator.animation_finished
	enemy.finished_attacking()
	
#During attack animation, Hitbox is activated and tries to find the player
func _on_hit_box_body_entered(body):
	if body.is_in_group("Player"):
		deal_damage_to_player(body)

#Connect and deal damage to the player
func deal_damage_to_player(player : PlayerMain):
	hit_particles.emitting = true
	player._take_damage(attack.damage)
	
func play_hitground_sound():
	AudioManager.play_sound(AudioManager.ENEMY_HIT, 0, -10)
	



