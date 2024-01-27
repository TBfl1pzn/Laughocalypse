extends CharacterBody2D
@export var bullet_speed = 0.9

var direction: Vector2 = Vector2(200, 200)

var feather_stopped = false

func _ready():
	pass

func _physics_process(delta):
	if feather_stopped:
		bullet_speed = 0
	var collision_info = move_and_collide(direction * bullet_speed)
	if collision_info:
		direction = direction.bounce(collision_info.get_normal())
		direction.x *= bullet_speed
		direction.y *= bullet_speed
		rotation = direction.angle()

func _on_timer_timeout():
	feather_stopped = true
