class_name ControlScheme
extends Resource

@export var sensitivity := 5 ## How quickly the player can rotate

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


# Get how much the player's character wants to rotate within the last frame
func _get_look_delta(_event: InputEvent, _device: int) -> Vector2:
	return Vector2.ZERO
