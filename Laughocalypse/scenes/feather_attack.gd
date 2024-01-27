extends Area2D

@onready var attack_cooldown:Timer = $Timer
var enemies_in_area = []
var feather_timeout = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("hit") and Global.feather_number == 1 and attack_cooldown.is_stopped():
		print("process")
		attack_cooldown.start()
		for i in enemies_in_area:
			i.hit()

func _on_body_entered(body):
	print(body.name)
	if body.name == "Enemy":
		enemies_in_area.append(body)

func _on_body_exited(body):
	if body.name == "Enemy":
		for i in len(enemies_in_area):
			if enemies_in_area[i] == body:
				enemies_in_area.remove_at(i)
