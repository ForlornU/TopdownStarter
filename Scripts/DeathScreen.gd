extends Node

#NOTE this class is attached to the death_screen scene that shows up when the player dies
#is handles the logic for resetting the level

func _process(_delta):
	if Input.is_action_just_pressed("Restart"):
		restart()

#When the player dies and wishes to reset, remove all of their money and reload the level
func restart():
	GameManager.reset_money()
	GameManager.load_same_level()

