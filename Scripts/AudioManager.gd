extends Node

#This class preloads all of our sound effects so that they can be played at a momets notice
#region New Code Region

const PLAYER_ATTACK_HIT = preload("res://Art/Audio/Effects/AttackHit.ogg")
const PLAYER_ATTACK_SWING = preload("res://Art/Audio/Effects/AttackSwing.ogg")
const ENEMY_HIT = preload("res://Art/Audio/Effects/Enemy_hit.ogg")
const BLOODY_HIT = preload("res://Art/Audio/Effects/bloody_hit.ogg")
const COIN_PICK = preload("res://Art/Audio/Effects/coin_pick.ogg")

#endregion
var audio_player : AudioStreamPlayer 

#Play a sound, call this function from anywhere
#offset lets you start the sound with an offset, like starting the sound at 0.1s into the clip
#Arguments(audio_clip, offset, volume)
#Example when calling this function:
#AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.25, 1)
func play_sound(audiostream : AudioStreamOggVorbis, offset : float, volume : float):
	if(not audio_player):
		initiate_audio_stream()

	audio_player.stream = audiostream
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.volume_db = volume
	audio_player.play(offset)

#Instantiate an audiostream into the scene, this only happens if none already exists
func initiate_audio_stream():
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.max_polyphony = 4
