extends Button

func restart_application():
	var executable_path = OS.get_executable_path()
	OS.execute(executable_path, [])  # Pass any command line arguments if needed
	get_tree().quit()


func _on_button_pressed():
		print("restart ?")
