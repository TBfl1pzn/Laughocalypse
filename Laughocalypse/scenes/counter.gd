extends MarginContainer

@onready var label = $RichTextLabel
@onready var timer = $Timer
var countdown = 7
var waves = 1

func _ready():
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	$"../WaveCounter/Wave".text = str(waves)

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _on_timer_timeout():
	for i in waves:
		$"../../".addEnemy()

	timer.start(countdown)
	waves = waves + 1
	$"../WaveCounter/Wave".text = str(waves)
	
	if (countdown > 4):
		countdown = countdown - 1
	
func _process(delta):
	label.text = "Next wave in %02d:%02d" % time_left_to_live()
	
