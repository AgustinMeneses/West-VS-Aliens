extends Control

@export var GameScene:PackedScene

var is_changing_level=false
var LEVEL_1 = preload("res://scenes/levels/Level_1.tscn").instantiate()
var change_scene=null
@onready var path_follow_2d = $Path2D/PathFollow2D

var but_pressed:bool=false
@export var speed=-0.9

func _ready():
	add_to_group("levels")
	if GameManager.levels_completed.has("Level_1"):
		$Panel/Buttons/Unavailable.visible=false
func _process(delta):
	path_follow_2d.progress_ratio+=speed*delta
	if is_changing_level:
		$Music.volume_db-=0.5
	if path_follow_2d.progress_ratio==1:
		get_tree().change_scene_to_file("res://scenes/levels/level_selector.tscn")
	elif path_follow_2d.progress_ratio==0:
		set_process(false)
		pass

func _on_start_game_pressed():
	if but_pressed==true: return
	but_pressed=true
	$shooting.play()
	await $shooting.finished
	get_tree().change_scene_to_file("res://scenes/levels/Level_1.tscn")
	pass # Replace with function body

func _on_exit_pressed():
	if but_pressed: return
	but_pressed=true
	get_tree().quit()
	pass # Replace with function body.

func _on_start_game_mouse_entered():
	$no_bullets.play()
	pass # Replace with function body.

func _on_exit_mouse_entered():
	$no_bullets.play()
	pass # Replace with function body.

func _on_credits_pressed():
	if but_pressed: return
	but_pressed=true
	$shooting.play()
	$AnimationPlayer.play("Fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/credits.tscn")
	#get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
	pass # Replace with function body.


func _on_select_level_pressed():
	$shooting.play()
	speed=0.9
	is_changing_level=true
	set_process(true)
	pass # Replace with function body.


func _on_credits_mouse_entered():
	$no_bullets.play()
	pass # Replace with function body.


func _on_select_level_mouse_entered():
	if not $Panel/Buttons/Unavailable.is_visible_in_tree():return
	$no_bullets.play()
	pass # Replace with function body.
