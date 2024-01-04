extends State
class_name enemy_attack_state

#@export var damage_frames : Array[int]
var has_made_sound = false 
var has_dealt_damage

signal DealDamage
@export var damage = 25

@onready var enemy = $"../.."
@onready var hitbox = $"../../AnimatedSprite2D/HitBox/CollisionShape2D"
@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"
@export var animator : AnimationPlayer

func Enter():
	has_made_sound = false
	has_dealt_damage = false
	hitbox.disabled = true

	animator.play("Attack")
	await animator.animation_finished
	enemy.finished_attacking()
	
func Exit():
	has_dealt_damage = false
	hitbox.disabled = true
	
#During attack animation, Hitbox is activated and tries to find the player
func _on_hit_box_body_entered(body):
	if body.is_in_group("Player") and has_dealt_damage == false:
		AudioManager.play_sound(AudioManager.ENEMY_HIT, 0, -10)
		var player = body as PlayerMain
		deal_damage_to_player(player)

#Connect and deal damage to the player
func deal_damage_to_player(player):
	hit_particles.emitting = true
	
	player.ConnectForDamage(self)
	emit_signal("DealDamage", damage)
	has_dealt_damage = true


