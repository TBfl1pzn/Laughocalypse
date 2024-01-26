extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.	
var feather = 1

var feather_spawn: Marker2D
@export var feather_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	feather_spawn = $FeatherSpawn
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		print("move_right")
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		print("move_left")
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		print("move_down")
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		print("move_up")
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	
	if Input.is_action_pressed("shoot"):
		if feather == 1:
			feather -= 1
			shoot()
			
func shoot():
	var feather_instance = feather_scene.instantiate()
	feather_instance.position = feather_spawn.get_global_position()
	feather_instance.rotation = rotation
	feather_instance.direction = Vector2(1.0,0.0).rotated(rotation).normalized()
	get_tree().get_root().call_deferred("add_child", feather_instance)
