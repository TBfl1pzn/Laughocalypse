extends CharacterBody2D

@export var player: CharacterBody2D
const speed = 10
var life = 4
@onready var audioStreamPlayer: AudioStreamPlayer = $AudioStreamPlayer

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


func _on_hit_box_body_entered(body):
	if body.name == "FlyingFeather":
		life -= 1
		audioStreamPlayer.play()
	
	if life <= 0:
		queue_free()
