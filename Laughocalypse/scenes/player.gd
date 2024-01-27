extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var clientId = 0

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
	
	if (!Multiplayer.multiplayer.is_server()
		and Multiplayer.multiplayer.get_unique_id() == clientId):
		Multiplayer.Test.rpc_id(1, position, clientId)	
	
	
