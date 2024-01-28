extends Area2D

@export var player: CharacterBody2D
@onready var attack_cooldown:Timer = $Timer
var enemies_in_area = []
var feather_timeout = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("hit") and Global.feather_number == 1 and attack_cooldown.is_stopped():
		attack_cooldown.start()
		player.attackMelee()
		for i in enemies_in_area:
			i.hit()

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		enemies_in_area.append(body)

func _on_body_exited(body):
	if body.is_in_group("enemy"):
		var count_up = 0
		for i in enemies_in_area:
			if i == body:
				enemies_in_area.remove_at(count_up)
				count_up += 1
