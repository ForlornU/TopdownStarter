extends Node

var current_quest : Quest
@export var quest_label : Label

func new_quest(new_quest : Quest):
	quest_label.text = new_quest.quest_name + "\n" + new_quest.quest_description
	pass


