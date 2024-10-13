extends Node
var money:int=100

var can_plant="rechazado"
var kills:int=0
var but_pressed:int=2

var last_enemy_killed:Enemy

var tilesOcupadas:Array=[]
var levels_completed:Array=[]

signal update_money(money)
signal no_money(money)
signal update_progress_bar(kills)
signal p_bar_plant(p_bar,time_plant)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func restart_tiles_ocupadas():
	money=100
	tilesOcupadas=[]
	kills=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_money_collected(new_money:int):
	money+=new_money
	if money<0:
		money-=new_money
		no_money.emit(money)
		return can_plant
	update_money.emit(money)
	
func _on_enemy_dead(enemy):
	last_enemy_killed=enemy
	kills+=1
	update_progress_bar.emit(kills)
	pass

func plant_placed(tile_pos):
	tilesOcupadas.append(tile_pos)

func plant_destroyed(selected_plant):
	tilesOcupadas.erase(selected_plant)

func tile_ocupada(tile_pos):
	return tile_pos in tilesOcupadas

func _get_arrray():
	return tilesOcupadas

func _level_completed(level):
	levels_completed.append(level)
	pass
