class_name Player
extends Node
## Controls a player's actions and attributes

## Character that the player is playing as
var character: Character
## What kind of input the player is using
var input_type: Game.INPUT_TYPE = Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
## Index of the controller the player is using, if any
var controller_index := 0


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
	else:
		set_name("ControllerPlayer" + str(new_index))
