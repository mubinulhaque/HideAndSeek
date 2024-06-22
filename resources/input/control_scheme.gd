class_name ControlScheme
extends Resource

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
