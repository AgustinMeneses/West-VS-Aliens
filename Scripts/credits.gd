extends PathFollow2D
@export var speed:int=70
@onready var credits = $"../../Control"

var but_pressed:bool=false
var is_timer_done=false
func _ready():
	set_process(true)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress_ratio==1:
		if is_timer_done:
			await get_tree().create_timer(3)
			is_timer_done=true
		
		
	progress+=speed*delta
	pass

func _input(event):
	if Input.is_action_pressed("left_click"):
		speed=240
	if Input.is_action_just_released("left_click"):
		speed=70
	if Input.is_action_just_pressed("right_click"):
		if not but_pressed:
			but_pressed=true
			$"../../AnimationPlayer".play("Fade_out")
			await $"../../AnimationPlayer".animation_finished
			get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
