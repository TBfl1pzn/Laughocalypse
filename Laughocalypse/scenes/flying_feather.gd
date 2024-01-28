extends CharacterBody2D
@export var feather_speed = 2

var direction: Vector2 = Vector2(200, 200)
@export var player: CharacterBody2D
@onready var timer: Timer = $Timer

var feather_stopped = false

func _ready():
	pass

func _physics_process(delta):
	if feather_stopped:
		
		direction = Vector2(0, 0)
		if (player.position.x + 10) >= position.x:
			direction += Vector2(1, 0)
		if (player.position.x + 10) <= position.x:
			direction += Vector2(-1, 0)
		if (player.position.y - 10) >= position.y:
			direction += Vector2(0, 1)
		if (player.position.y - 10) <= position.y:
			direction += Vector2(0, -1)
		direction = direction * 2
		rotation = direction.angle()

	velocity = direction * feather_speed
	var collision_info = move_and_collide(velocity)
	
	if collision_info:
		direction = direction.bounce(collision_info.get_normal())
		rotation = direction.angle()

func _on_timer_timeout():
	feather_stopped = true
	
