extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var executable_path = OS.get_executable_path()
	OS.execute(executable_path, [])
	get_tree().quit()
