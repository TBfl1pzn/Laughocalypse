extends Panel

@onready var sprite = $Sprite2D

func update(whole: bool):
	if whole: sprite.frame = 0
	else: sprite.frame = 4
