class_name Bullets
extends Area2D

@export var speed:float=150
var direction : Vector2

func _ready():
	add_to_group("bullets")

func set_direction(dir:Vector2):
	direction=dir
	pass
func _physics_process(delta:float):
	translate(direction*speed*delta)
	pass

func _on_area_entered(area:Area2D):
	var enemy:Enemy=area
	var damage=5
	enemy._take_damage(damage)
	queue_free()
	pass # Replace with function body.


func _area_entered():
	queue_free()
