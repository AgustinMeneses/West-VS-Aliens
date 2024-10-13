extends Area2D


func _on_area_entered(_area):
	print("moriste")
	get_tree().change_scene_to_file("res://scenes/levels/detah_screen.tscn")
	pass
