class_name SplitscreenContainer
extends SubViewportContainer

var model_render_layer := 0
var target: Node3D:
	set(value):
		target = value
		name = target.name + "_Viewport"

@onready var camera: Camera3D = $SubViewport/Camera3D


func _process(_delta: float) -> void:
	if target:
		# If there is a target to follow
		camera.global_position = target.global_position
		camera.global_rotation = target.global_rotation
		
		if target is Model:
			# If the target is a model
			camera.global_position.y = target.global_position.y + target.offset
			camera.global_rotation.y = target.global_rotation.y - PI


# Sets the render layers of the camera
# We don't want the player's character model to be rendered
# nor any other player's hand models
func set_render_layers(player_index: int, player_count: int) -> void:
	if camera:
		# Disable rendering other players' hand models
		for layer: int in range(3, (player_count * 2) + 2, 2):
			camera.set_cull_mask_value(layer, false)
		
		# Disable rendering this player's character model
		model_render_layer = (player_index * 2) + 2
		camera.set_cull_mask_value(model_render_layer, false)
		
		if target is Model:
			target.set_visibility_layer(model_render_layer)
		
		# Enable rendering this player's hand model
		camera.set_cull_mask_value(model_render_layer + 1, true)
