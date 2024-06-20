extends Control

signal switch_scene(new_scene_key: String)
signal player_ready(
		character: Character,
		input_type: Game.INPUT_TYPE,
		controller_index: int,
)

@export var player_slots: Array[PlayerSlot]

var active_controllers: Array[int]
var active_keyboard := false

@onready var switch_scene_button: Button = $SwitchSceneButton


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_join"):
		# Handle players joining
		if get_first_available_slot() != -1:
			# If there are any available player slots
			# Get the first available player slot
			# Assign it to the keyboard and mouse or the correct controller
			var player_slot := player_slots[get_first_available_slot()]
			
			if event is InputEventKey and not active_keyboard:
				# If the new player is using the keyboard and mouse
				print("Keyboard player has joined!")
				active_keyboard = true
				player_slot.visible = true
				
				player_slot.add_keyboard_player()
			elif (
					event is InputEventJoypadButton
					and event.device not in active_controllers
			):
				# If the new player is using a controller
				print("Joypad player ", event.device, " has joined using ",  Input.get_joy_name(event.device), "!")
				player_slot.visible = true
				active_controllers.append(event.device)
				
				player_slot.add_controller_player(event.device)
		else:
			print("No available slots!")


func get_first_available_slot() -> int:
	for i in range(player_slots.size()):
		if not player_slots[i].visible:
			return i
	
	return -1


func _on_player_left(keyboard_player: bool, controller_index: int) -> void:
	if keyboard_player and active_keyboard:
		# If the player to leave was using the keyboard and mouse
		# Set the keyboard and mouse to be available
		active_keyboard = false
	else:
		# If the player to leave was using a controller
		# Set that controller to be available
		active_controllers.remove_at(active_controllers.find(controller_index))


## Sends the signal up to Game
func _on_player_ready(
		character: Character,
		input_type: Game.INPUT_TYPE,
		controller_index: int,
) -> void:
	player_ready.emit(character, input_type, controller_index)
	
	var ready_slots := 0
	for slot in player_slots:
		if slot.is_player_ready:
			ready_slots += 1
	
	if ready_slots >= 2:
		switch_scene_button.visible = true


func _on_all_players_ready() -> void:
	switch_scene.emit("example_world")
