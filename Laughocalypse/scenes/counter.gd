extends MarginContainer

@onready var label = $RichTextLabel
@onready var timer = $Timer
var countdown = 7
var waves = 1

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	$"../WaveCounter/Wave".text = str(waves)

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [second]
	
func _on_timer_timeout():
	if $"../../".enemies == 0:
		waves = waves + 1
		$"../..".setRandomMap()
		for i in waves:
			$"../..".addEnemy()
		
		$"../WaveCounter/Wave".text = str(waves)
	
	
	
