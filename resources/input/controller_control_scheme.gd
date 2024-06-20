class_name ControllerControlScheme
extends ControlScheme

## What value that a joystick's value must be higher than to be registered
@export_range(0, 1, 0.05) var deadzone := 0.5

@export_group("Movement")
## Axis that moves a character forwards
@export var forwards: JoyAxis
## Axis that moves a character to the right
@export var right: JoyAxis

@export_group("Looking")
## Event to rotate a camera horizontally
@export var horizontal_look: JoyAxis
## Event to rotate a camera vertically
@export var vertical_look: JoyAxis

var _last_forwards_axis_value: float = 0


func _get_forwards_speed(input_event: InputEvent, device: int) -> float:
	if input_event is InputEventJoypadMotion:
		# If the event is from a controller's joystick
		var axis_value := Input.get_joy_axis(device, forwards)
		
		if abs(axis_value) >= deadzone:
			# If the axis' value is higher than or equal to the deadzone
			_last_forwards_axis_value = -axis_value
		else:
			# If the axis' value is higher than the deadzone
			_last_forwards_axis_value = 0
	
	return _last_forwards_axis_value
