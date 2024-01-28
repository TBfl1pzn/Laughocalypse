extends Node

@onready var songPlayer1: AudioStreamPlayer = $SongPlayer1
@onready var songPlayer2: AudioStreamPlayer = $SongPlayer2
@onready var songPlayer3: AudioStreamPlayer = $SongPlayer3
@onready var songPlayer4: AudioStreamPlayer = $SongPlayer4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var executable_path = OS.get_executable_path()
	OS.execute(executable_path, [])
	get_tree().quit()
