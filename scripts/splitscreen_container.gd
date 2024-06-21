class_name SplitscreenContainer
extends SubViewportContainer

var target: Node3D:
	set(value):
		target = value
		name = target.name + "_Viewport"

@onready var camera: Camera3D = $SubViewport/Camera3D


func _process(_delta: float) -> void:
	if target:
		# If there is a target to follow
		if target is Model:
			camera.global_position = target.offset.global_position
			camera.global_rotation = target.offset.global_rotation
		else:
			camera.global_position = target.global_position
			camera.global_rotation = target.global_rotation
		
