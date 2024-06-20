class_name MouseControlScheme
extends ControlScheme

@export_group("Movement")
@export var left: Key ## Key that moves a character to the left
@export var right: Key ## Key that moves a character to the right
@export var forwards: Key ## Key that moves a character forwards
@export var backwards: Key ## Key that moves a character backwards

@export_group("Looking")
@export var invert_x := false ## Whether to invert the mouse's X axis
@export var invert_y := false ## Whether to invert the mouse's Y axis

var _last_forwards_speed := 0
var _last_strafe_speed := 0


func _get_forwards_speed(input_event: InputEvent, _device: int) -> float:
	if input_event is InputEventKey:
		# If the event is from the keyboard
		var event: InputEventKey = input_event
		var forwards_speed := 1 if event.keycode == forwards and event.pressed else 0
		var backwards_speed := 1 if event.keycode == backwards and event.pressed else 0
		_last_forwards_speed = forwards_speed - backwards_speed
	
	return _last_forwards_speed


func _get_strafe_speed(input_event: InputEvent, _device: int) -> float:
	if input_event is InputEventKey:
		# If the event is from the keyboard
		var event: InputEventKey = input_event
		var right_speed := 1 if event.keycode == right and event.pressed else 0
		var left_speed := 1 if event.keycode == left and event.pressed else 0
		_last_strafe_speed = right_speed - left_speed
	
	return _last_strafe_speed
