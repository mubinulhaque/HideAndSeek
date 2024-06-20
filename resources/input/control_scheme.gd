class_name ControlScheme
extends Resource

@export_group("Movement")
@export var left: InputEvent ## Event that moves a character to the left
@export var right: InputEvent ## Event that moves a character to the right
@export var forwards: InputEvent ## Event that moves a character forwards
@export var backwards: InputEvent ## Event that moves a character backwards

@export_group("Other Actions")
@export var flashlight: InputEvent ## Event that turns on the flashlight
