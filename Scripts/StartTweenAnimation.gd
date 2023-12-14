extends Sprite2D
var starting_scale : Vector2

#NOTE This class animates an object by changing its scale, it is currently not applied to anything

func _ready():
	visible = false
	starting_scale = scale
	grow()

func grow():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", starting_scale * 0.8, 1)
	await tween.finished
	shrink()
		
func shrink():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "scale", starting_scale * 1.2, 1)
	await tween.finished
	grow()


