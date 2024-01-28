extends CharacterBody2D

@export var speed = 100 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.	
var feather_spawn: Marker2D
var health = 100
var kills = 0
@export var feather_scene: PackedScene
@onready var combat_feather = $FeatherAttack
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var meleeAttackTimer: Timer = $MeleeAttackTimer
var melee_triggered = false
var last_walk_direction

signal health_changed(health)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	feather_spawn = $FeatherSpawn
	screen_size = get_viewport_rect().size
	$"../CanvasLayer/KillsCounter/Kills".text = str(kills)

func handleInput():
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_pressed("shoot"):
		if has_feather():
			Global.feather_number = 0
			shoot()

	if Global.feather_number == 0:
		combat_feather.hide()
	else:
		combat_feather.show()

	# Set current animation
	if melee_triggered == true:
		animationPlayer.play("attack_" + get_aim_direction())
		meleeAttackTimer.start()
		melee_triggered = false
	else:
		if meleeAttackTimer.is_stopped():
			if velocity.length() == 0:
				animationPlayer.stop()
			if has_feather():
				animationPlayer.play("walk_" + get_aim_direction() + "_feather")
			else:
				animationPlayer.play("walk_" + get_aim_direction())

func get_aim_direction():
	if velocity.x > 0:
		last_walk_direction = "right"
		return "right"
	elif velocity.x < 0:
		last_walk_direction = "left"
		return "left"
	else:
		if last_walk_direction:
			return last_walk_direction
		else:
			# Called on the first frame
			return "right"

func shoot():
	var feather_instance = feather_scene.instantiate()
	feather_instance.player = self
	feather_instance.position = feather_spawn.get_global_position()
	if velocity.x > 0:
		feather_instance.rotation = rotation
		feather_instance.direction = Vector2(1.0,0.0).rotated(rotation).normalized()
	elif velocity.x < 0:
		feather_instance.direction = Vector2(-1.0, 0.0).rotated(rotation).normalized()
		feather_instance.rotation = feather_instance.direction.angle()
	else:
		feather_instance.rotation = rotation
		feather_instance.direction = Vector2(1.0,0.0).rotated(rotation).normalized()
	get_tree().get_root().call_deferred("add_child", feather_instance)

func attackMelee():
	melee_triggered = true

func _physics_process(delta):
	handleInput()

	var collision_info = move_and_slide()
	if collision_info:
		var body_name = get_last_slide_collision().get_collider()
		
		if body_name.is_in_group("enemy"):
			health = health - 1
			health_changed.emit(health)

func _on_feather_attack_body_entered(body):
	pass # Replace with function body.

func has_feather():
	return Global.feather_number == 1


func _on_area_2d_body_entered(body):
	if body.is_in_group("flying_feather") and body.timer.is_stopped():
		Global.feather_number = 1
		get_tree().call_group("flying_feather", "queue_free")
