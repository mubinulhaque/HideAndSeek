extends PlayerSlotState

signal character_changed(new_icon: Texture2D)
signal input_selection_returned
signal arrows_visible
signal player_ready(character: Character)

@export var characters: Array[Character]

var current_character := 0


func _enter() -> void:
	# Change the main icon to the first character's icon
	# and make the arrows visible
	arrows_visible.emit()
	if characters.size() > 0:
		character_changed.emit(characters[0].icon)


func _on_cancel_button_pressed() -> void:
	# Transition back to the Input Selection state
	transitioned.emit(self, "InputSelection")
	input_selection_returned.emit()


func _on_arrow_pressed(action: int) -> void:
	# Scroll between characters
	current_character = (current_character + action) % characters.size()
	character_changed.emit(characters[current_character].icon)


func _on_accept_button_pressed() -> void:
	player_ready.emit(characters[current_character])
