extends PathFollow2D
#class_name Enemy
@onready var anim: AnimationPlayer= $AnimationPlayer
@export var vel:float=30

var is_alive:bool=true

func _ready():
	anim.play("Idle")
	pass

func _process(delta):
	progress+=delta*vel
	pass

func _take_damage()->void:
	is_alive=false
	set_process(false)
	queue_free()
	

