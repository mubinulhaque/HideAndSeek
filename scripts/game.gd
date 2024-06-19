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

var players: Array[Player] = []

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
			# Hook up the correct signal to switch scenes
			print("Scene has the correct signal for scene switching!")
			current_scene.switch_scene.connect(switch_scene)
		else:
			# If the new scene has no correct signal for scene switching
			print("Scene does not have the signal for scene switching!")
		
		if current_scene.has_signal("player_ready"):
			# If the new scene has the correct signal for making players
			# Hook up the correct signal to make players
			print("Scene has the correct signal for making players!")
			current_scene.player_ready.connect(make_player)
		else:
			# If the new scene has no correct signal for making players
			print("Scene does not have the signal for making players!")
		
		if current_scene.has_signal("add_characters"):
			# If the new scene has the correct signal for adding characters
			# Hook up the correct signal to add characters
			print("Scene has the correct signal for adding characters!")
			current_scene.add_characters.connect(add_characters)
		else:
			# If the new scene has no correct signal for  adding characters
			print("Scene does not have the signal for adding characters!")
	else:
		# If the new scene cannot be loaded
		print("Unable to find a scene with the key: ", new_scene_key)


func make_player(
		character: Character, 
		input_type: INPUT_TYPE,
		controller_index: int,
) -> void:
	print("Made new player with the character ", 
			character.name,
			" using ",
			str(input_type),
			" with the controller index of ",
			str(controller_index),
			"!",
	)
	var player := Player.new(character, input_type, controller_index)
	add_child(player)
	players.append(player)


## Adds a character for each player
func add_characters(positions: Array[Vector2], world: Node) -> void:
	for i in range(0, players.size()):
		var model: PackedScene = load(players[i].character.model)
		
		if model:
			print("Loading model for player ", i)
			var new_char: Node = model.instantiate()
			world.add_child(new_char)
			new_char.position = Vector3(positions[i].x, 0.1, positions[i].y)
		else:
			print("Cannot load model at: ", players[i].character.model)
