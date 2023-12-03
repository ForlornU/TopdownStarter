extends Node

#This class preloads all of our sound effects
const PLAYER_ATTACK_HIT = preload("res://Art/Audio/Effects/AttackHit.ogg")
const PLAYER_ATTACK_SWING = preload("res://Art/Audio/Effects/AttackSwing.ogg")

var audio_player : AudioStreamPlayer 

#Play a sound with a slightly random pitch
func play_sound(audiostream : AudioStreamOggVorbis, offset : float):
	if(not audio_player):
		initiate_audio_stream()

	audio_player.stream = audiostream
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play(offset)

#Instantiate an audiostream into the scene
func initiate_audio_stream():
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
