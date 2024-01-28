extends CharacterBody2D
@export var feather_speed = 2

var direction: Vector2 = Vector2(200, 200)
@export var player: CharacterBody2D

var feather_stopped = false

func _ready():
	pass

func _physics_process(delta):
	
	if feather_stopped:
		direction = Vector2(0, 0)
		#feather_speed = 1
		if player.position.x > position.x:
			direction += Vector2(1, 0)
		if player.position.x < position.x:
			direction += Vector2(-1, 0)
		if player.position.y > position.y:
			direction += Vector2(0, 1)
		if player.position.y < position.y:
			direction += Vector2(0, -1)

	velocity = direction * feather_speed
	var collision_info = move_and_collide(velocity)
	
	if collision_info:
		direction = direction.bounce(collision_info.get_normal())
		direction.x *= feather_speed
		direction.y *= feather_speed
		rotation = direction.angle()

func _on_timer_timeout():
	feather_stopped = true
	
