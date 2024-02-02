extends Node
class_name QuestTracker

#Keep track of our current quest and allow for changing/updating of new quests
const QUESTRESOURCE = preload("res://Scenes/QuestTemplate.tscn")
var current_quest : Quest
@export var quest_info : Label
@export var quest_announcement : Label

func _ready():
	#Add current quest as a blank Quest Node
	quest_announcement.text = ""
	current_quest = QUESTRESOURCE.instantiate()
	add_child(current_quest)

func start_new_quest(new_quest : Quest):
	#Duplicate the values of the new quest
	current_quest.quest_id = new_quest.quest_id
	current_quest.quest_name = new_quest.quest_name
	current_quest.quest_description = new_quest.quest_description
	current_quest.quest_reward = new_quest.quest_reward

	quest_info.text = new_quest.quest_name + ":\n" + new_quest.quest_description
	announce_quest("New Quest! \n" + new_quest.quest_name)
	pass

#Not in use.. update description here
func update_quest(source_quest : Quest, updated_description : String):
	if !source_quest:
		print("recieved quest is null")
		return
		
	if !current_quest:
		print("current quest is null")
		return
		
	if source_quest.quest_id != current_quest.quest_id:
		print("Quests did not match.." )
		return
		
	quest_info.text = updated_description

#Not in use.. finish quest and give reward here
func complete_quest(quest : Quest):
	GameManager.add_money(quest.quest_reward)
	announce_quest("Quest completed!")
	current_quest.text = ""
	quest.free() #is this really a good idea?

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
