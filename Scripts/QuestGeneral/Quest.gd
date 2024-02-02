@icon("res://Art/Icons/QuestSprite.png")
extends Node
class_name Quest

#This general Quest class defines what a quest is
@export var quest_id : int
@export var quest_name : String
@export var quest_objective : Array[String]
@export var quest_reward : int

