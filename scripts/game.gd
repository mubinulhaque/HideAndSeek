class_name Game
extends Node

enum INPUT_TYPE {
	PLAYSTATION,
	XBOX,
	SWITCH,
	STEAMDECK,
	KEYBOARD_AND_MOUSE,
}

const scenes: Dictionary = {
	"main_menu": "res://scenes/main_menu.tscn",
	"player_selection": "res://scenes/player_selection_screen.tscn",
	"example_world": "res://scenes/worlds/example_world.tscn",
}
const splitscreen_container : = preload("res://scenes/splitscreen_container.tscn")

@export var screen_layouts: Array[SplitscreenLayoutGroup]
@export var initial_scene: String

static var default_keyboard_control_scheme := load("res://control_schemes/default_keyboard_scheme.tres")
static var default_controller_control_scheme := load("res://control_schemes/default_controller_scheme.tres")

var _players: Array[Player] = []
var _layout_index := 0

@onready var current_scene: Node


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
	_players.append(player)


## Adds a character for each player
func add_characters(positions: Array[Vector2], world: Node) -> void:
	for i in range(0, _players.size()):
		# For each player
		# Load their model and name it appropriately
		var model: PackedScene = load(_players[i].character.model)
		
		if model:
			# Place the model in the wold
			print("Loading model for player ", i)
			var new_char: Node = model.instantiate()
			world.add_child(new_char)
			new_char.position = Vector3(positions[i].x, 0.1, positions[i].y)
			
			# Name the model
			if _players[i].input_type == INPUT_TYPE.KEYBOARD_AND_MOUSE:
				new_char.name = _players[i].character.name + "_Keyboard"
			else:
				new_char.name = (_players[i].character.name 
						+ "_Controller" + str(_players[i].controller_index))
			
			# Set the player's model to this model
			_players[i].model = new_char
		else:
			print("Cannot load model at: ", _players[i].character.model)
		
		if _players.size() > 1 and screen_layouts.size() + 1 >= _players.size():
			# If a splitscreen layout has been set for this number of players
			var new_container: SplitscreenContainer = splitscreen_container.instantiate()
			var current_layout := screen_layouts[_players.size() - 2].layouts[_layout_index]
			
			new_container.name = "Player" + str(i) + "Viewport"
			new_container.position = Vector2(
				current_layout.portions[i].x,
				current_layout.portions[i].y,
			)
			new_container.size = Vector2(
				current_layout.portions[i].width,
				current_layout.portions[i].height,
			)
			world.add_child(new_container)
	
	if _players.size() <= 1:
		print("Not enough players!")
	elif screen_layouts.size() + 1 < _players.size():
		print("No splitscreen layout has been set for this number of players!")
