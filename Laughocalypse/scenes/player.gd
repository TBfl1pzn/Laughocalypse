extends CharacterBody2D

@export var speed = 100 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.	
var feather_spawn: Marker2D
var health = 100
@export var feather_scene: PackedScene

signal health_changed(health)

# Called when the node enters the scene tree for the first time.
func _ready():
	feather_spawn = $FeatherSpawn
	screen_size = get_viewport_rect().size

func handleInput():
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("shoot"):
		if Global.feather_number == 1:
			Global.feather_number = 0
			shoot()
			
func shoot():
	var feather_instance = feather_scene.instantiate()
	feather_instance.position = feather_spawn.get_global_position()
	feather_instance.rotation = rotation
	feather_instance.direction = Vector2(1.0,0.0).rotated(rotation).normalized()
	get_tree().get_root().call_deferred("add_child", feather_instance)
	
func _physics_process(delta):
	handleInput()

	var collision_info = move_and_slide()
	if collision_info:
		var body_name = get_last_slide_collision().get_collider()
		
		if body_name.is_in_group("enemy"):
			health = health - 1
			health_changed.emit(health)
		
		if body_name.name == "FlyingFeather":
			Global.feather_number = 1
			get_tree().call_group("flying_feather", "queue_free")

func _on_feather_attack_body_entered(body):
	pass # Replace with function body.
