extends CharacterBody2D

@export var player: CharacterBody2D
const speed = 25
var life = 4
@onready var hit1: AudioStreamPlayer = $AudioHit1
@onready var hit2: AudioStreamPlayer = $AudioHit2
@onready var hit3: AudioStreamPlayer = $AudioHit3
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _process(delta):
	if velocity.x > 0:
		animationPlayer.play("walk_right")
	else:
		animationPlayer.play("walk_left")

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

func hit():
	print("hit")
	life -= 1
	if life == 3:
		hit1.play()
	elif life == 2:
		hit2.play()
	elif life == 1:
		hit3.play()	
	if life <= 0:
		queue_free()

func _on_hit_box_body_entered(body):
	print(body.name)
	print(body.is_in_group("feather_attack"))
	if body.name == "FlyingFeather":
		hit()
