extends Node

#This might be a roundabout way to get a reference to the
#quest tracker on the player
@export var quest : Quest

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Giving Player a quest!")
		var quest_tracker_node = body.find_child("QuestTracker") as QuestTracker
		quest_tracker_node.start_new_quest(quest)
	pass # Replace with function body.
