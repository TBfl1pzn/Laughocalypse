extends CharacterBody2D

@export var player: CharacterBody2D
const speed = 10

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity = Vector2(0, 0)

	if player.position.x > position.x:
		velocity += Vector2(1, 0)
	if player.position.x < position.x:
		velocity += Vector2(-1, 0)
	if player.position.y > position.y:
		velocity += Vector2(0, 1)
	if player.position.y < position.y:
		velocity += Vector2(0, -1)

	velocity = velocity * speed

	move_and_slide()
