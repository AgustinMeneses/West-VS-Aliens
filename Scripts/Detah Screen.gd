extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2).timeout
	$AnimationPlayer.play("restart")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass