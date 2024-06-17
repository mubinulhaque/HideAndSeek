extends Control

signal switch_scene(new_scene_key: String) ## Switch to a specific scene


func _on_input_manager_button_pressed() -> void:
	switch_scene.emit("player_selection")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
