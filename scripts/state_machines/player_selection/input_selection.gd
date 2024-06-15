class_name InputSelection
extends PlayerSlotState

signal input_type_changed(
		new_diagram: Texture2D,
		new_accept_icon: Texture2D,
		new_cancel_icon: Texture2D,
		new_input_type: Game.INPUT_TYPE,
)
signal player_left

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
			input_type_changed.emit(
					xbox_icons.diagram,
					xbox_icons.action_south,
					xbox_icons.action_east,
					Game.INPUT_TYPE.XBOX,
			)
			current_controller_type = 0
		Game.INPUT_TYPE.PLAYSTATION:
			input_type_changed.emit(
					playstation_icons.diagram,
					playstation_icons.action_south,
					playstation_icons.action_east,
					Game.INPUT_TYPE.PLAYSTATION
			)
			current_controller_type = 1
		Game.INPUT_TYPE.STEAMDECK:
			input_type_changed.emit(
					steamdeck_icons.diagram,
					steamdeck_icons.action_south,
					steamdeck_icons.action_east,
					Game.INPUT_TYPE.STEAMDECK,
			)
			current_controller_type = 2
		Game.INPUT_TYPE.SWITCH:
			input_type_changed.emit(
					switch_icons.diagram,
					switch_icons.action_south,
					switch_icons.action_east,
					Game.INPUT_TYPE.SWITCH,
			)
			current_controller_type = 3


func set_to_keyboard() -> void:
	input_type_changed.emit(
			keyboard_diagram,
			null,
			null,
			Game.INPUT_TYPE.KEYBOARD_AND_MOUSE
	)


func _on_arrow_pressed(action: int) -> void:
	var new_controller_type := (
			(current_controller_type + action) % controller_icons.size()
	)
	
	current_controller_type = new_controller_type
	input_type_changed.emit(
			controller_icons[current_controller_type].diagram,
			controller_icons[current_controller_type].action_south,
			controller_icons[current_controller_type].action_east,
			controller_types[current_controller_type],
	)


func _on_cancel_button_pressed() -> void:
	# Remove the player
	player_left.emit()


func _on_accept_button_pressed() -> void:
	print("Accept!")
