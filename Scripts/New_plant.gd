extends Node2D
@export var sprite:Texture
@export var level:int

var is_alr_pressed:bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	if not sprite==null:
		$Control/Panel/TextureRect.texture=sprite
	else:
		$Control/Panel/Label.text="LEVEL "+str(level)
	pass # Replace with function body.
