extends Node2D
@onready var TMap = $BackGround
@onready var timer = $Timer

@export var enemy_dmg_multiplier:float=1
@export var enemy_speed_multiplier:float=1

var BANK = preload("res://scenes/mecanics/bank.tscn").instantiate()

@export var y_placement:Array[int]

signal enemy_spawned()
func _ready():
	pass # Replace with function body.
func _level_finished():
	timer.queue_free()
	BANK._level_finished()
	get_tree().call_group("enemies","_take_damage",10000)
	
func wave_setter(rango:int):
	for i in range(rango):
		_spawn_aliens()
		await get_tree().create_timer(0.7).timeout
		pass
	pass

func _on_timer_timeout():
	_spawn_aliens()
	pass # Replace with function body.

func _spawn_aliens():
	var enemy = preload("res://scenes/objects/enemy.tscn").instantiate()
	var random=y_placement.pick_random()
	var tile_vector=Vector2i(11,random)
	var world_pos=TMap.map_to_local(tile_vector)
	enemy.position=world_pos
	enemy.atk*=enemy_dmg_multiplier
	enemy.vel*=enemy_speed_multiplier
	add_child(enemy)
	enemy_spawned.emit()
	if timer==null:return
	timer.start()

func _on_area_2d_area_entered(_area):
	if _area.is_in_group("bullets"):
		_area._area_entered()
	pass # Replace with function body.
