class_name ControllerControlScheme
extends ControlScheme

## Index of the player's controller
@export var controller_index := 0
## What value that a joystick's value must be higher than to be registered
@export_range(0, 1, 0.05) var deadzone := 0.5

@export_group("Movement")
## Axis that moves a character forwards
@export var forwards: InputEventJoypadMotion
## Axis that moves a character to the right
@export var right: InputEventJoypadMotion

@export_group("Looking")
## Event to rotate a camera to the left
@export var look_left: InputEventJoypadMotion
## Event to rotate a camera to the right
@export var look_right: InputEventJoypadMotion
## Event to rotate a camera up
@export var look_up: InputEventJoypadMotion
## Event to rotate a camera down
@export var look_down: InputEventJoypadMotion

var _last_forwards_axis_value : float = 0


func _get_forwards_speed(input_event: InputEvent) -> float:
	if input_event is InputEventJoypadMotion:
		# If the event is from a controller's joystick
		var axis_value := Input.get_joy_axis(controller_index, forwards.axis)
		
		if abs(axis_value) >= deadzone:
			# If the axis' value is higher than or equal to the deadzone
			_last_forwards_axis_value = -axis_value
		else:
			# If the axis' value is higher than the deadzone
			_last_forwards_axis_value = 0
	
	return _last_forwards_axis_value
