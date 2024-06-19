class_name World
extends Node

signal add_characters(positions: Vector2, world: Node)

@export var spawn_positions: Array[Vector2]


func _on_spawn_timer_timeout() -> void:
	print("Spawning characters!")
	add_characters.emit(spawn_positions, self)
