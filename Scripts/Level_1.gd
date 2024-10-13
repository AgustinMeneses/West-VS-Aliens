extends Node2D
class_name LEVEL

var speed:int=70

var enemy = preload("res://scenes/objects/enemy.tscn")
var pause_menu = preload("res://scenes/mecanics/pause_menu.tscn").instantiate()

@onready var spawn_aliens = $SpawnAliens
@onready var texture_progress_bar = $"UI/progress bar/TextureProgressBar"
@onready var buff_label=$AnimationPlayer/Label

@export var kills_needed:Array[int]=[]
@export var wait_times:Array[float]=[]
@export var wave_number:Array[int]=[]
@export var name_level:String
@export var next_level:String
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_aliens.enemy_spawned.connect(enemy_spawned)
	$"UI/progress bar".visible=false
	$AnimationPlayer/Label.visible=false
	get_tree().paused=true	
	set_process(false)
	add_to_group("levels")
	GameManager.restart_tiles_ocupadas()
	$AnimationPlayer.play("start")
	await $AnimationPlayer.animation_finished
	if spawn_aliens.enemy_dmg_multiplier >1:
		enemy_buffed("ATK")
		print("enemy DMG buffed")
		await $AnimationPlayer.animation_finished
	if spawn_aliens.enemy_speed_multiplier >1:
		enemy_buffed("VEL")
		print("enemy VEL buffed")
		await $AnimationPlayer.animation_finished
	get_tree().paused=false
	add_child(pause_menu)
	$AnimationPlayer/Music2.stop()
	$Music.play()
	spawn_aliens.timer.start()

func _on_music_finished():
	$Music.play()
	pass # Replace with function body.

func _on_esc_pressed(r,g,b):
	$".".modulate=Color(r,g,b)
	pass

func wait_timer_reduced(kills):
	if kills == kills_needed[0]:
		print("wave_1")
		spawn_aliens.timer.wait_time=wait_times[0]
	elif kills== kills_needed[1]:
		print("wave_2")
		spawn_aliens.wave_setter(wave_number[0])
		spawn_aliens.timer.wait_time=wait_times[1]
	if kills==texture_progress_bar.max_value:
		GameManager._level_completed(name_level)
		$AnimationPlayer.play("Next_plant")
		spawn_aliens._level_finished()
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file(next_level)
		#get_tree().change_scene_to_file(next_level)
	pass

func enemy_buffed(tipe:String):
	buff_label.visible=true
	if tipe=="VEL":
		buff_label.text="VELOCIDAD DE
	ENEMIGOS X"+str(spawn_aliens.enemy_speed_multiplier)
		pass
	elif tipe=="ATK":
		buff_label.text="ATAQUE DE
	ENEMIGOS X"+str(spawn_aliens.enemy_dmg_multiplier)
	$AnimationPlayer.play("dmg_buffed")

func enemy_spawned():
	$"UI/progress bar".visible=true
