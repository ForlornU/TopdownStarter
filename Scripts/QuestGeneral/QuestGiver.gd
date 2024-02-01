extends Node

@export var quest : Quest

#When player enters: Give quest, play a sound, destroy self
func _on_body_entered(body):
	if can_give_quest(body):
		give_quest(body)
		queue_free()

func give_quest(player):
	print("Giving Player a quest!")
	AudioManager.play_sound(AudioManager.COIN_PICK, 0, -10)
		
	#This might be a roundabout way to get a reference to the quest tracker on the player..
	var quest_tracker_node = player.find_child("QuestTracker") as QuestTracker
	quest_tracker_node.start_new_quest(quest)

func can_give_quest(body):
	#Only player is eligible and quest must be assigned. '!quest' means quest is null
	if !body.is_in_group("Player") || !quest:
		return false
	else:
		return true
