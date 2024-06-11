extends Control

signal switch_scene(scene_file_path: String) ## Switch to a specific scene


func _on_input_manager_button_pressed() -> void:
	switch_scene.emit("res://scenes/")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
