extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var clientId = 0
@onready var syncPosTimer: Timer = $SyncPosTimer

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed	

func test(name):
	$Label.text = name

func _physics_process(delta):
	if (!Multiplayer.multiplayer.is_server()
		and Multiplayer.multiplayer.get_unique_id() == clientId):
		handleInput()
		
	move_and_slide()
	
func _process(delta):
	if (!Multiplayer.multiplayer.is_server()
		and Multiplayer.multiplayer.get_unique_id() == clientId
		and syncPosTimer.is_stopped()):
		Multiplayer.Test.rpc_id(1, position, clientId)	
		syncPosTimer.start()
