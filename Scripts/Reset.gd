extends Node

#NOTE this class is attached to the death_screen and victory_screen scene that shows up when the player dies
#it handles the logic for resetting the level or quitting the game

func _process(_delta):
	if Input.is_action_just_pressed("Restart"):
		restart()
	if Input.is_action_just_pressed("Escape"):
		get_tree().quit()

#When the player dies and wishes to reset, remove all of their money and reload the level
func restart():
	GameManager.reset_money()
	GameManager.load_same_level()
