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
		var overlap_areas = get_overlapping_areas()
		for area in overlap_areas:
			if area.is_in_group("enemyHitboxes"):
				var enemy = area.get_parent()
				enemy.hit()
