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
## How much the character wants to rotate in the last frame
var look_delta: Vector2 = Vector2.ZERO


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
	var forwards_strength := control_scheme._get_forwards_speed(controller_index)
	var strafe_strength := control_scheme._get_strafe_speed(controller_index)
	
	if model:
		# Get the direction the model should rotate in
		var direction := (model.transform.basis * Vector3(
				-strafe_strength,
				0,
				forwards_strength,
		)).normalized()
		
		if direction:
			model.position.x += direction.x * MOVEMENT_SPEED * delta
			model.position.z += direction.z * MOVEMENT_SPEED * delta
		
		if input_type != Game.INPUT_TYPE.KEYBOARD_AND_MOUSE:
			# If the player is using a controller
			# Note: needed to ensure smooth player rotation
			model.rotate_y(-look_delta.x * control_scheme.sensitivity * delta)
		
		if model is Model:
			# If the player is controlling a model
			var player_model: Model = model
			player_model.set_forwards_strength(forwards_strength)
			player_model.set_strafe_strength(strafe_strength)
			
			if input_type != Game.INPUT_TYPE.KEYBOARD_AND_MOUSE:
				# If the player is using a controller
				# Note: needed to ensure smooth player rotation
				model.head.rotate_x(look_delta.y * control_scheme.sensitivity * delta)


func _input(event: InputEvent) -> void:
	# Get how much the player wants to rotate
	look_delta = control_scheme.get_look_delta(event, controller_index)
	
	if model and input_type == Game.INPUT_TYPE.KEYBOARD_AND_MOUSE:
		# If the player is using the mouse and keyboard
		# Note: needed to ensure that the player stops endlessly rotating
		model.rotate_y(deg_to_rad(-look_delta.x * control_scheme.sensitivity))
		model.head.rotate_x(deg_to_rad(look_delta.y * control_scheme.sensitivity))
