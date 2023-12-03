extends Node

func _process(delta):
	if Input.is_action_just_pressed("Restart"):
		restart()

func restart():
	GameManager.reset_money()
	GameManager.load_same_level()

