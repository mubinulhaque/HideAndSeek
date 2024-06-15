class_name InputSelection
extends State

signal input_type_changed(new_icon: Texture2D, new_input_type: Game.INPUT_TYPE)

@export var keyboard_diagram: Texture2D
@export var xbox_icons: ControllerIconProfile
@export var playstation_icons: ControllerIconProfile
@export var steamdeck_icons: ControllerIconProfile
@export var switch_icons: ControllerIconProfile

@onready var controller_icons := [
	xbox_icons, 
	playstation_icons,
	steamdeck_icons,
	switch_icons,
]
@onready var controller_types := [
	Game.INPUT_TYPE.XBOX, 
	Game.INPUT_TYPE.PLAYSTATION,
	Game.INPUT_TYPE.STEAMDECK,
	Game.INPUT_TYPE.SWITCH,
]
@onready var current_controller_type := 0


func set_to_controller(input_type: Game.INPUT_TYPE) -> void:
	match input_type:
		Game.INPUT_TYPE.XBOX:
			input_type_changed.emit(xbox_icons.diagram, Game.INPUT_TYPE.XBOX)
			current_controller_type = 0
		Game.INPUT_TYPE.PLAYSTATION:
			input_type_changed.emit(playstation_icons.diagram, 
					Game.INPUT_TYPE.PLAYSTATION)
			current_controller_type = 1
		Game.INPUT_TYPE.STEAMDECK:
			input_type_changed.emit(steamdeck_icons.diagram, 
					Game.INPUT_TYPE.STEAMDECK)
			current_controller_type = 2
		Game.INPUT_TYPE.SWITCH:
			input_type_changed.emit(switch_icons.diagram, 
					Game.INPUT_TYPE.SWITCH)
			current_controller_type = 3


func set_to_keyboard() -> void:
	input_type_changed.emit(keyboard_diagram, Game.INPUT_TYPE.KEYBOARD_AND_MOUSE)


func switch_controller_type(action: int) -> void:
	var new_controller_type := current_controller_type
	
	if action > 0:
		new_controller_type = (
				(current_controller_type + 1) % controller_icons.size()
		)
	elif action < 0:
		new_controller_type = (
				(current_controller_type - 1) % controller_icons.size()
		)
	
	current_controller_type = new_controller_type
	input_type_changed.emit(controller_icons[current_controller_type].diagram,
			controller_types[current_controller_type])
