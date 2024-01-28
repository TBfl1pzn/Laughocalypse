extends Node2D

var enemies = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Finish.hide()
	setRandomMap()
	$Player.health_changed.connect(_on_health_change)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_health_change(health):
	if health == 0:
		get_tree().paused = true
		$Finish/WavesContainer/Waves.text = str($CanvasLayer/Counter.waves)
		$Finish/KillsContainer/Kills.text = str($Player.kills)
		$Finish.show()

	$CanvasLayer/Health/ProgressBar.value = health
	
func setRandomMap():
	var Maps = [$Gras,$Desert,$Ice,$Mountain]
	var randomIndex = randi_range(0,3);
	var randomMap = Maps[randomIndex];
	
	for i in Maps:
		i.hide()
	randomMap.show()
	
		
func addEnemy():
	var scene = load("res://scenes/enemies/enemy.tscn")
	var instance = scene.instantiate()
	
	var x_range = Vector2(50, 600)
	var y_range = Vector2(50, 300)

	instance.position.x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	instance.position.y  =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
	instance.player = $Player
	add_child(instance)

