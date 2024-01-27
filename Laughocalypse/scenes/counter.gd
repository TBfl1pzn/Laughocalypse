extends MarginContainer

@onready var label = $RichTextLabel
@onready var timer = $Timer


func _ready():
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _on_timer_timeout():
	# spawn enemy here
	print(123)
	
	
func _process(delta):
	label.text = "%02d:%02d for next wave to spawn" % time_left_to_live()
	
