extends State
class_name enemy_attack_state

@export var damage_frames : Array[int]
var on_frame_four = false 
var has_dealt_damage

signal DealDamage
@export var damage = 25

@onready var enemy = $"../.."
@onready var sprite = $"../../AnimatedSprite2D"
@onready var hitbox = $"../../AnimatedSprite2D/HitBox/CollisionShape2D"
@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"

func Enter():
	on_frame_four = false
	has_dealt_damage = false
	hitbox.disabled = true

	sprite.play("Attack")
	await sprite.animation_finished
	enemy.finished_attacking()
	
func Exit():
	has_dealt_damage = false
	hitbox.disabled = true
	
func Update(_delta):
	#If we are currently on the damage frames, thats frame 3 and 4, allow damage to be dealt
	if damage_frames.has(sprite.frame):
		if has_dealt_damage == false:
			hitbox.disabled = false
			#Play a sound if weapon only hits the ground
			if(sprite.frame == 4 and on_frame_four != true):
				on_frame_four = true
				AudioManager.play_sound(AudioManager.ENEMY_HIT, 0, -10)
				pass
	else:
		hitbox.disabled = true

#During attack animation, Hitbox is activated and tries to find the player
func _on_hit_box_body_entered(body):
	if body.is_in_group("Player") and has_dealt_damage == false:
		var player = body as PlayerMain
		deal_damage_to_player(player)

#Connect and deal damage to the player
func deal_damage_to_player(player):
	hit_particles.emitting = true
	
	player.ConnectForDamage(self)
	emit_signal("DealDamage", damage)
	has_dealt_damage = true


