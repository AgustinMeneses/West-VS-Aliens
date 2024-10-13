extends Panel
@onready var button = $Button
@onready var tMap = $"../../Map"


signal plants_destroyed(selected_tower)

var is_destroyed:bool=false
var is_pressed: bool =false
var alr_pressed:bool=false
var selected_tower=null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func  _ready():
	plants_destroyed.connect(GameManager.plant_destroyed)
	pass
func _process(_delta):
	if is_pressed==true:
		var des= get_child(-1)
		des.global_position=get_global_mouse_position()
		if Input.is_action_just_pressed("left_click"):
			destroy_plants()
			des.global_position=$Marker2D.global_position
			is_pressed=false
			alr_pressed=false
		if Input.is_action_just_pressed("right_click"):
			des.global_position=$Marker2D.global_position
			is_pressed=false
			alr_pressed=false
		get_tree().call_group("map","esta_presionado",is_pressed)
	pass


func _on_button_pressed():
	if alr_pressed==true: return
	is_pressed=true
	alr_pressed=true
	pass # Replace with function body.

func _on_area_2d_area_entered(body):
	if body.is_in_group("plantas"):
		selected_tower = body
	pass # Replace with function body.

func _on_area_2d_area_exited(body):
	#print("adios")
	if body==selected_tower:
		selected_tower=null
	pass # Replace with function body.

func destroy_plants():
	is_destroyed=false
	if selected_tower:
		is_destroyed=true
		var tile_pos=tMap.tile_vector
		print(tile_pos)
		GameManager.plant_destroyed(tile_pos)
		selected_tower.queue_free()
		selected_tower=null
	pass
