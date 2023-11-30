extends Control

@export var money_label : Label

func _process(delta):
	# Set the score label text to the score variable in game manager script
	money_label.text = "%d" % GameManager.money
