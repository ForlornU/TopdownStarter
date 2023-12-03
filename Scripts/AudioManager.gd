extends Node

#This class preloads all of our sound effects
const PLAYER_ATTACK_HIT = preload("res://Art/Audio/Effects/AttackHit.ogg")
const PLAYER_ATTACK_SWING = preload("res://Art/Audio/Effects/AttackSwing.ogg")
const ENEMY_HIT = preload("res://Art/Audio/Effects/Enemy_hit.ogg")
const BLOODY_HIT = preload("res://Art/Audio/Effects/bloody_hit.ogg")

var audio_player : AudioStreamPlayer 

#Play a sound with a slightly random pitch
func play_sound(audiostream : AudioStreamOggVorbis, offset : float, volume : float):
	if(not audio_player):
		initiate_audio_stream()

	audio_player.stream = audiostream
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.volume_db = volume
	audio_player.play(offset)

#Instantiate an audiostream into the scene
func initiate_audio_stream():
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.max_polyphony = 4
