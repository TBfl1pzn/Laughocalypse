extends CharacterBody2D


@export var clientId = 0
@onready var syncPosTimer: Timer = $SyncPosTimer

func test(name):
	$Label.text = name

@export var speed = 100 # How fast the player will move (pixels/sec).
var feather_spawn: Marker2D
@export var feather_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	feather_spawn = $FeatherSpawn
	if is_my_client():
		var camera = Camera2D.new()
		add_child(camera)

func handleInput():
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection * speed
	
	var collision_info = move_and_slide()
	if collision_info:
		var body_name = get_last_slide_collision().get_collider()
		print(body_name.name)
		if body_name.name == "FlyingFeather":
			Global.feather_number = 1
			get_tree().call_group("flying_feather", "queue_free")
	

func shoot():
	print("shoot")
	if is_my_client():
		#var feather_instance = feather_scene.instantiate()
		var feather_position = feather_spawn.get_global_position()
		var feather_rotation = rotation
		var feather_direction = Vector2(1.0,0.0).rotated(rotation).normalized()
		#get_tree().get_root().call_deferred("add_child", feather_instance)
		Multiplayer.ShareFeatherPosition.rpc_id(1, feather_direction, feather_rotation, feather_position, clientId)	
		
func _physics_process(delta):
	if is_my_client():
		handleInput()
		
	move_and_slide()
	
func _process(delta):
	if is_my_client():
		look_at(get_global_mouse_position())

		if Input.is_action_pressed("shoot"):
			if Global.feather_number == 1:
				Global.feather_number = 0
				shoot()

	if is_my_client() and syncPosTimer.is_stopped():
		Multiplayer.SharePlayerPosition.rpc_id(1, position, clientId)	
		syncPosTimer.start()

func is_my_client():
	return (!Multiplayer.multiplayer.is_server()
		and Multiplayer.multiplayer.get_unique_id() == clientId)
