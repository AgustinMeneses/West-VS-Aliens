extends Control


func _input(event):
	if Input.is_action_just_pressed("esc"):
		get_tree().call_group("levels","_on_esc_pressed",0.5,0.5,0.5)
		$".".visible=true
		get_tree().paused=true

func _on_continue_pressed():
	get_tree().paused=false
	$".".visible=false
	get_tree().call_group("levels","_on_esc_pressed",1,1,1)
	pass # Replace with function body.

func _on_back_to_menu_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
	pass # Replace with function body.
