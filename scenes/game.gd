extends Node

@onready var current_scene: Node = $MainMenu


func _on_main_menu_switch_scene(scene_file_path: String) -> void:
	print(scene_file_path)
