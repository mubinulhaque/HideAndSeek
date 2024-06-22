class_name Model
extends Node3D

@export var offset := 1.0

const LERP_WEIGHT := 0.25

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var skeleton: Skeleton3D = $Armature/Skeleton3D


# Blend between the animation for moving forwards
# and the animation for backwards
func set_forwards_strength(strength: float) -> void:
	animation_tree["parameters/moving/blend_position"].y = lerpf(
			animation_tree["parameters/moving/blend_position"].y,
			strength,
			LERP_WEIGHT
	)


# Blend between the animation for strafing left 
# and the animation for strafing right
func set_strafe_strength(strength: float) -> void:
	animation_tree["parameters/moving/blend_position"].x = lerpf(
			animation_tree["parameters/moving/blend_position"].x,
			strength,
			LERP_WEIGHT
	)


# Plays the dying animation
func die() -> void:
	if animation_tree:
		animation_tree["parameters/conditions/dying"] = true
	else:
		print("No animation tree attached to ", name, "!")


# Sets the layers the model can be visible on
func set_visibility_layer(layer: int) -> void:
	for child in skeleton.get_children(true):
		if child is VisualInstance3D:
			var instance: VisualInstance3D = child
			instance.set_layer_mask_value(1, false)
			instance.set_layer_mask_value(layer, true)
