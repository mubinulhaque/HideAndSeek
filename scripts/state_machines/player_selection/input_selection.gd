class_name InputSelection
extends State

signal main_icon_changed(new_texture: Texture2D)

@export var keyboard_diagram: Texture2D
@export var xbox_icons: ControllerIconProfile
@export var playstation_icons: ControllerIconProfile
@export var steamdeck_icons: ControllerIconProfile
@export var switch_icons: ControllerIconProfile

func set_to_controller(input_type: Game.INPUT_TYPE) -> void:
	match input_type:
		Game.INPUT_TYPE.XBOX:
			main_icon_changed.emit(xbox_icons.diagram)
		Game.INPUT_TYPE.PLAYSTATION:
			main_icon_changed.emit(playstation_icons.diagram)
		Game.INPUT_TYPE.STEAMDECK:
			main_icon_changed.emit(steamdeck_icons.diagram)
		Game.INPUT_TYPE.SWITCH:
			main_icon_changed.emit(switch_icons.diagram)

func set_to_keyboard() -> void:
	main_icon_changed.emit(keyboard_diagram)
