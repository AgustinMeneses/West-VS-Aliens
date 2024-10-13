extends TileMap

var drawing_layer:int=1
var previous_tile=null
var atlas_coords=Vector2(0,0)
var tile_id:int=4

var plant_selector = preload("res://Scripts/plant_selector.gd")
var tile_vector:Vector2i
var is_outside=false

func _ready():
	add_to_group("map")
	set_physics_process(false)
	
func _physics_process(_delta):
	var tile=local_to_map(get_global_mouse_position()) 
	tile_vector=Vector2i(tile)
	if previous_tile and previous_tile !=tile_vector:
		set_cell(drawing_layer,previous_tile,-1)
	set_cell(drawing_layer,tile_vector,tile_id,atlas_coords)
	previous_tile=tile_vector
	if Input.is_action_just_pressed("left_click"):
		set_cell(drawing_layer,tile_vector,-1)
		var tiles_datas=get_used_cells(0)
		if not tile_vector in tiles_datas:
			is_outside=true
			get_tree().call_group("plant_sel","esta_posicionado_en_la_arena",is_outside)
		else:
			is_outside=false
			get_tree().call_group("plant_sel","esta_posicionado_en_la_arena",is_outside)
	if Input.is_action_just_pressed("right_click"):
		set_cell(drawing_layer,tile_vector,-1)
		#aca deberia haber un if, que pregunte si en la casilla en la que estas es una casilla del id 1
	pass


func esta_presionado(is_pressed):
	if is_pressed:
		set_physics_process(true)
	else:
		set_physics_process(false)
		previous_tile=null
	pass
