class_name Model
extends Node3D

const LERP_WEIGHT := 0.25

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var offset: Marker3D = $Offset


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


func die() -> void:
	if animation_tree:
		animation_tree["parameters/conditions/dying"] = true
	else:
		print("No animation tree attached to ", name, "!")
