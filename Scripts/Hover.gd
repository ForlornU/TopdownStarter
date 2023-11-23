extends Sprite2D

#Movement
var time_passed = 0
var initial_position := Vector2.ZERO
@export var amplitude := 4.0
@export var frequency := 5.0

func _ready():
	initial_position = position

func _process(delta):
	body_hover(delta)

func body_hover(delta):
	time_passed += delta
	var new_y = initial_position.y + amplitude * sin(frequency * time_passed)
	position.y = new_y
