class_name ControllerControlScheme
extends ControlScheme

@export_group("Looking")
@export var look_left: InputEventJoypadMotion ## Event to rotate a camera to the left
@export var look_right: InputEventJoypadMotion ## Event to rotate a camera to the right
@export var look_up: InputEventJoypadMotion ## Event to rotate a camera up
@export var look_down: InputEventJoypadMotion ## Event to rotate a camera down


func set_device(index: int = 0) -> void:
	left.device = index
	right.device = index
	forwards.device = index
	backwards.device = index
	
	look_left.device = index
	look_right.device = index
	look_up.device = index
	look_down.device = index
	
	flashlight.device = index
