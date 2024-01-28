extends Control

@onready var songPlayer1: AudioStreamPlayer = $SongPlayer1
@onready var songPlayer2: AudioStreamPlayer = $SongPlayer2
@onready var songPlayer3: AudioStreamPlayer = $SongPlayer3
@onready var songPlayer4: AudioStreamPlayer = $SongPlayer4

# Called when the node enters the scene tree for the first time.
func _ready():
	songPlayer3.play()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
