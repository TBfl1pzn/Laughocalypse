extends Node2D

@onready var player = $World/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func addEnemy():
	var scene = load("res://scenes/enemies/enemy.tscn")
	var instance = scene.instantiate()
	instance.position.x = 150
	instance.position.y = 50
	instance.player = $Player
	add_child(instance)

