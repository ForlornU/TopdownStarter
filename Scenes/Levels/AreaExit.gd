extends Area2D

@onready var label = $Label
@export var basement_scene : PackedScene

func _ready():
	label.visible = false

func _process(_delta):
	if(Input.is_action_just_pressed("Enter") and label.visible == true):
		GameManager.load_next_level(basement_scene)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		label.visible = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		label.visible = false
