extends CharacterBody2D

@export var player: CharacterBody2D
const speed = 10
var life = 4
@onready var audioStreamPlayer: AudioStreamPlayer = $AudioStreamPlayer
@onready var hit2: AudioStreamPlayer = $AudioHit2
@onready var hit3: AudioStreamPlayer = $AudioHit3



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
		if life == 3:
			audioStreamPlayer.play()
		elif life == 2:
			hit2.play()
		elif life == 1:
			hit3.play()	
		if life <= 0:
			queue_free()
