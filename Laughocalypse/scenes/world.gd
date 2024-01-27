extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.health_changed.connect(_on_health_change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_health_change(health):
	
	if health == 0:
		get_tree().paused = true
	$CanvasLayer/Health/ProgressBar.value = health
	

func addEnemy():
	var scene = load("res://scenes/enemies/enemy.tscn")
	var instance = scene.instantiate()
	instance.position.x = 150
	instance.position.y = 50
	instance.player = $Player
	add_child(instance)

