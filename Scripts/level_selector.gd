extends Node2D
@export var speed=0.9
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.levels_completed.has("Level_1"):
		$Level_2_unavailable.visible=false
		pass
	if GameManager.levels_completed.has("Level_2"):
		$Level_3_unavailable.visible=false
	if GameManager.levels_completed.has("Level_3"):
		$Level_4_unavailable.visible=false
		pass
	pass # Replace with function body.

func _process(delta):
	$Path2D/PathFollow2D.progress_ratio+=speed*delta
	if $Path2D/PathFollow2D.progress_ratio==0:
		get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")

	if $Path2D/PathFollow2D.progress_ratio==1:$Control/Reverb.visible=true
	else: $Control/Reverb.visible=false

func _on_reverb_pressed():
	speed*=-1
	pass # Replace with function body.

func _on_level_1_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/levels/Level_1.tscn")
	pass # Replace with function body.


func _on_level_2_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/levels/Level_2.tscn")
	pass # Replace with function body.


func _on_level_3_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/levels/Level_3.tscn")
	pass # Replace with function body.


func _on_level_4_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/levels/Level_4.tscn")
	pass # Replace with function body.


func _on_level_5_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/levels/level_5.tscn")
	pass # Replace with function body.


func _on_level_1_mouse_entered():
	$no_bullets.play()
	pass # Replace with function body.


func _on_level_2_mouse_entered():
	$no_bullets.play()
	pass # Replace with function body.


func _on_level_3_mouse_entered():
	$no_bullets.play()
	pass # Replace with function body.


func _on_level_4_mouse_entered():
	$no_bullets.play()
	pass # Replace with function body.


func _on_level_5_mouse_entered():
	$no_bullets.play()
	pass # Replace with function body.
