extends Node2D
var plant_scene=preload("res://scenes/objects/planta_rodadora.tscn").instantiate()
@onready var tMap = $TileMap
var tilesOcupadas:Array=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos=get_global_mouse_position()
		var tile_pos=tMap.world_to_map(mouse_pos)
		if not tile_ocupada(tile_pos):
			place_plant(tile_pos)
		else:
			print("linea ocupada")


func tile_ocupada(tile_pos):
	return tile_pos in tilesOcupadas

func place_plant(tile_pos):
	var plant_instance = plant_scene.instance()
	var world_pos=tMap.map_to_world(tile_pos)
	plant_instance.position=world_pos
	add_child(plant_instance)
	tilesOcupadas.append(tile_pos)
	print("planta colocada en celda ",tile_pos)
	pass
