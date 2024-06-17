class_name Game
extends Node

enum INPUT_TYPE {
	PLAYSTATION,
	XBOX,
	SWITCH,
	STEAMDECK,
	KEYBOARD_AND_MOUSE,
}

@export var initial_scene: String

@onready var current_scene: Node = $MainMenu
@onready var scenes: Dictionary = {
	"main_menu": "res://scenes/main_menu.tscn",
	"player_selection": "res://scenes/player_selection_screen.tscn",
	"example_world": "res://scenes/example_world.tscn",
}


func _ready() -> void:
	if initial_scene:
		switch_scene(initial_scene)
	else:
		print("No initial scene picked!")


## Switches from the current scene to a new scene
func switch_scene(new_scene_key: String) -> void:
	var new_scene: PackedScene = load(scenes.get(new_scene_key))
	
	if new_scene:
		# If the new scene can be loaded
		# Instantiate it as a child of this node
		var scene: Node = new_scene.instantiate()
		add_child(scene)
		
		if current_scene:
			# If there is already a current scene
			# Delete it
			current_scene.queue_free()
		
		# Set the current scene to the new scene
		current_scene = scene
			
		if current_scene.has_signal("switch_scene"):
			# If the new scene has the correct signal for scene switching
			# Hook up the correct signal to allow scene switching
			print("Scene has the correct signal!")
			current_scene.switch_scene.connect(switch_scene)
		else:
			# If the new scene has no correct signal for scene switching
			print("Scene does not have the correct signal!")
	else:
		# If the new scene cannot be loaded
		print("Unable to find a scene with the key ", new_scene_key)
