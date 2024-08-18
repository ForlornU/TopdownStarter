extends Control

@export var money_label : Label

func _process(_delta):
	money_label.text = "Coins: " + "%d" % GameManager.money
