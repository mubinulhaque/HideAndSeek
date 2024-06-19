class_name Player
extends Node
## Controls a player's actions and attributes

## Character that the player is playing as
var character: Character
## What kind of input the player is using
var input_type: Game.INPUT_TYPE = Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
## Index of the controller the player is using, if any
var controller_index := 0
## Model to control
var model: Node3D


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


func _input(event: InputEvent) -> void:
	if model and event.is_pressed():
		# If the player has a model assigned to it
		if input_type == Game.INPUT_TYPE.KEYBOARD_AND_MOUSE:
			if event is InputEventKey:
				if event.keycode == KEY_ENTER:
					model.rotate_y(PI / 2)
		elif event.device == controller_index:
			if event is InputEventJoypadButton:
				if event.button_index == JOY_BUTTON_A:
					model.rotate_y(PI / 2)
