extends Node

var money = 0

func add_money(addmoney : int):
	money += addmoney
	print("You have: " + money)

func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
