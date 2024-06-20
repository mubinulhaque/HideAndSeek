class_name Player
extends Node
## Controls a player's actions and attributes

## Speed that a character moves at
const MOVEMENT_SPEED = 5

## Character that the player is playing as
var character: Character
## What kind of input the player is using
var input_type: Game.INPUT_TYPE = Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
## Index of the controller the player is using, if any
var controller_index := 0
## Model to control
var model: Node3D
## Controls that this player can use to control their character
var control_scheme: ControlScheme
## Current forwards speed of the character
var forwards_speed: float = 0


func _init(
		new_character: Character,
		new_input: Game.INPUT_TYPE,
		new_index: int,
) -> void:
	character = new_character
	input_type = new_input
	controller_index = new_index
	
	if input_type == Game.INPUT_TYPE.KEYBOARD_AND_MOUSE:
		set_name("KeyboardPlayer")
		control_scheme = Game.default_keyboard_control_scheme
	else:
		set_name("ControllerPlayer" + str(new_index))
		control_scheme = Game.default_controller_control_scheme


func _process(delta: float) -> void:
	if model:
		model.position.z += forwards_speed * delta


func _input(event: InputEvent) -> void:
	if model:
		# If the player has a model assigned to it
		forwards_speed = control_scheme._get_forwards_speed(event, controller_index) * MOVEMENT_SPEED
