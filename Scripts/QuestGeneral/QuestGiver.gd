extends Node

@export var quest : Quest

#When player enters: Give quest, play a sound, destroy self
func _on_body_entered(body):
	if !body.is_in_group("Player"):
		return

	if !quest:
		print("No quest assigned!")
		return

	give_quest(body)
	AudioManager.play_sound(AudioManager.COIN_PICK, 0, -10)
	queue_free()

func give_quest(player):
	print("Giving Player a quest!")
	#This might be a roundabout way to get a reference to the quest tracker on the player..
	var quest_tracker_node = player.find_child("QuestTracker") as QuestTracker
	quest_tracker_node.start_new_quest(quest)
