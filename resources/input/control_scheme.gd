class_name ControlScheme
extends Resource

@export var sensitivity := 5 ## How quickly the player can rotate

@export_group("Looking")
@export var invert_x := false ## Whether to invert the mouse's X axis
@export var invert_y := false ## Whether to invert the mouse's Y axis

@export_group("Other Actions")
@export var flashlight: InputEvent ## Event that turns on the flashlight


# Get the forwards speed of the player's character
# Note: always reports the last axis value to ensure that players cannot
# interfere with each other's movement
# Note: returns a value between -1 and 1
func _get_forwards_speed(_device: int) -> float:
	return 0


# Get the strafe speed of the player's character
# Note: always reports the last axis value to ensure that players cannot
# interfere with each other's movement
# Note: returns a value between -1 and 1
func _get_strafe_speed(_device: int) -> float:
	return 0


# Method to be overridden by child classes
# So that inverting x and y axes does not need to be duplicated
func _get_look_delta(_event: InputEvent, _device: int) -> Vector2:
	return Vector2.ZERO


# Get how much the player's character wants to rotate within the last frame
func get_look_delta(_event: InputEvent, _device: int) -> Vector2:
	var look_delta := _get_look_delta(_event, _device)
	
	if invert_x:
		look_delta.x = -look_delta.x
	
	if invert_y:
		look_delta.y = -look_delta.y
	
	return look_delta
