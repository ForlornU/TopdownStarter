extends Node
class_name QuestTracker

#Keep track of our current quest and allow for changing/updating of new quests

var current_quest : Quest
@export var quest_info : Label
@export var quest_announcement : Label

func _ready():
	quest_announcement.text = ""

func start_new_quest(new_quest : Quest):
	quest_info.text = new_quest.quest_name + ":\n" + new_quest.quest_description
	announce_quest("New Quest! \n" + new_quest.quest_name)
	pass

#Not in use.. update description here
func update_quest(updated_description : String):
	quest_info.text = updated_description
	pass

#Not in use.. finish quest and give reward here
func complete_quest(quest : Quest):
	GameManager.add_money(quest.quest_reward)
	announce_quest("Quest completed!")
	pass

#Show an announcement
func announce_quest(text : String):
	#set text but turn it invisible
	quest_announcement.text = text
	quest_announcement.modulate.a = 0
	
	#modulate:a changes the alpha of the announcement text. We fade to a value of 1 (visible)
	#tween.chain executes after the first tween, fading to an alpha of 0 (invisible)
	var tween = create_tween()
	tween.tween_property(quest_announcement, "modulate:a", 1, 1.5) #fade in
	tween.chain().tween_property(quest_announcement, "modulate:a", 0, 2.5) #fade out. Tween.chain starts after first tween is done
	await tween.finished
	quest_announcement.text = ""
