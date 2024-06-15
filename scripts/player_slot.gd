class_name PlayerSlot
extends ColorRect

var input_type: Game.INPUT_TYPE = Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
var controller_index := 0

@onready var main_icon: TextureRect = $MainIcon
@onready var input_selection: InputSelection = $StateMachine/InputSelection
@onready var left_arrow: TextureRect = $LeftArrow
@onready var right_arrow: TextureRect = $RightArrow


func _input(event: InputEvent) -> void:
	if (
			input_type != Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
			and event.device == controller_index
	):
		if event.is_action_pressed("menu_left"):
			print("Device ", controller_index, " has changed input type")
			input_selection.switch_controller_type(-1)
		elif event.is_action_pressed("menu_right"):
			print("Device ", controller_index, " has changed input type")
			input_selection.switch_controller_type(1)

## Allows only the keyboard to be selected
func add_keyboard_player() -> void:
	input_type = Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
	visible = true
	
	input_selection.set_to_keyboard()


## Allows only controllers to be selected
func add_controller_player(device_index: int) -> void:
	visible = true
	controller_index = device_index
	
	main_icon.texture = load("res://textures/input/xbox/diagram.svg")
	
	var controller_name := Input.get_joy_name(device_index).to_lower()
	if (
			"luna" in controller_name
			or "xbox" in controller_name
			or "xinput" in controller_name
	):
		input_selection.set_to_controller(Game.INPUT_TYPE.XBOX)
	elif (
			"ps3" in controller_name
			or "ps4" in controller_name
			or "ps5" in controller_name
	):
		input_selection.set_to_controller(Game.INPUT_TYPE.PLAYSTATION)
	elif (
			"stadia" in controller_name
			or "steam" in controller_name
	):
		input_selection.set_to_controller(Game.INPUT_TYPE.STEAMDECK)
	elif (
			"switch" in controller_name
			or "joy-Con" in controller_name
			or "joy Con" in controller_name
			or "joyCon" in controller_name
	):
		input_selection.set_to_controller(Game.INPUT_TYPE.SWITCH)
	else:
		input_selection.set_to_controller(Game.INPUT_TYPE.XBOX)


func _on_main_icon_changed(new_texture: Texture2D) -> void:
	main_icon.texture = new_texture


func _on_input_type_changed(new_icon: Texture2D, new_input_type: Game.INPUT_TYPE) -> void:
	_on_main_icon_changed(new_icon)
	input_type = new_input_type
	
	left_arrow.visible = new_input_type != Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
	right_arrow.visible = new_input_type != Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
