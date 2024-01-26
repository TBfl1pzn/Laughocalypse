extends Area2D
@export var bullet_speed = 69

var direction: Vector2 = Vector2(1.0, 0.0)

var feather_stopped = false

func _ready():
	pass

func _process(delta):
	if feather_stopped == false:
		position = position + bullet_speed * direction * delta


func _on_timer_timeout():
	feather_stopped = true
	
