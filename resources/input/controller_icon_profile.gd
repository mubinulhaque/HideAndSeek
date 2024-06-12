class_name ControllerIconProfile
extends Resource
## Establishes what icons should be used for each button
## on a specific type of controller

# Texture for the left DPad Button
const dpad_left: Texture2D = preload("res://textures/input/generic/dpad_left.svg")
# Texture for the right DPad Button
const dpad_right: Texture2D = preload("res://textures/input/generic/dpad_right.svg")
# Texture for the up DPad Button
const dpad_up: Texture2D = preload("res://textures/input/generic/dpad_up.svg")
# Texture for the down DPad Button
const dpad_down: Texture2D = preload("res://textures/input/generic/dpad_down.svg")

@export var diagram: Texture2D ## Texture for what the controller looks like

@export_group("Action Buttons")
@export var action_south: Texture2D ## Where the A button would be on an Xbox controller
@export var action_east: Texture2D ## Where the B button would be on an Xbox controller
@export var action_west: Texture2D ## Where the X button would be on an Xbox controller
@export var action_north: Texture2D ## Where the Y button would be on an Xbox controller

@export_group("Shoulders and Triggers")
@export var shoulder_left: Texture2D ## Texture for the left shoulder button
@export var trigger_left: Texture2D ## Texture for the left trigger
@export var shoulder_right: Texture2D ## Texture for the right shoulder button
@export var trigger_right: Texture2D ## Texture for the right trigger
