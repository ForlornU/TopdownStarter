extends Node
class_name QuestTracker

#Keep track of our current quest and allow for changing/updating of new quests

var current_quest : Quest
@export var quest_label : Label

func start_new_quest(new_quest : Quest):
	quest_label.text = new_quest.quest_name + ":\n" + new_quest.quest_description
	pass

#Not in use.. update description here
func update_quest(updated_description : String):
	quest_label.text = updated_description
	pass

