extends Node

@export var initial_state: State

var _states: Dictionary = {}
var current_state: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transition)
	
	if initial_state:
		initial_state._enter()
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state:
		current_state._update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_update(delta)


func _on_child_transition(old_state: State, new_state_name: String) -> void:
	if old_state != current_state:
		return
	
	var new_state: State = _states.get(new_state_name.to_lower())
	if not new_state:
		return
	
	if current_state:
		current_state._exit()
	
	new_state._enter()
	current_state = new_state