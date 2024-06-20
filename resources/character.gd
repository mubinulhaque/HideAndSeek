@icon("res://textures/menu/singleplayer.svg")
class_name Character
extends Resource

@export var name: String ## Name of the model
@export var icon: Texture2D ## Picture to be displayed during Character Selection
@export_file(".tscn") var model: String ## Path to the scene of the model
