extends MarginContainer

@onready var label = $RichTextLabel
@onready var timer = $Timer
var countdown = 5

func _ready():
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _on_timer_timeout():
	$"../../".addEnemy()
	timer.start(countdown)
	
	if (countdown > 1):
		countdown = countdown - 1
	
func _process(delta):
	label.text = "Next enemy in %02d:%02d!" % time_left_to_live()
	
