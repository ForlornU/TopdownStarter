extends Node
class_name State

#NOTE This is the State base-class, all our specific states inherits this logic
# DO NOT CHANGE THIS unless you know what you are doing

signal state_transition

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	pass
	
