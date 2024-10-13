extends Area2D
@onready var anim = $AnimationPlayer 
@onready var timer = $Timer


@export var coin_value:int=50

@export var speed:int=50

var presed:bool=false

func _ready():
	add_to_group("coins")
	var timer_random=randi_range(2,5)
	timer.wait_time=timer_random
	anim.play("time")
	set_physics_process(false)
	timer.start()

func _physics_process(delta):
	position.y-=speed*delta
	pass


func _on_input_event(_viewport, _event, _shape_idx):
	if presed==true:return
	if Input.is_action_just_pressed("left_click"):
		GameManager._on_money_collected(coin_value)
		anim.play("picked_up")
		presed=true
	pass # Replace with function body.

func _its_droping(is_droping):
	if is_droping:
		set_physics_process(true)

func _on_timer_timeout():
	set_physics_process(false)
	pass # Replace with function body.
