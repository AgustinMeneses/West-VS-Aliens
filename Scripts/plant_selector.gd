extends Panel
@onready var p_bar = $Panel/p_bar
@onready var tMap = $"../../Map"
@onready var audio = $audio
@onready var label = $Label

@export var ghost_tipe:PackedScene
@export var cooldown:float
@export var price:int
@export var label_price:String
@export var another_plant_scene: PackedScene
@export var sprite:Texture

var is_ghost_outside=null
var is_pressed:bool=false

signal plant_placed(tile_pos)
signal plant_erased(tile_pos)

func _ready():
	$TextureRect.texture=sprite
	label.text= "$"+str(label_price)
	$Panel/p_bar.max_value=cooldown
	add_to_group("plant_sel")
	pass # Replace with function body.

func _process(delta):
	if $Panel.is_visible_in_tree():
		var current_time:float=p_bar.value
		p_bar.value+=delta
		if current_time>=p_bar.max_value:
			p_bar.value=0
			$Panel.visible=false

	if is_pressed==true:
		var ghost=get_parent().get_parent().get_child(-1)
		ghost.global_position=get_global_mouse_position()
		if Input.is_action_just_pressed("right_click"):
			ghost.queue_free()
			is_pressed=false
		if Input.is_action_just_pressed("left_click"):
			ghost.queue_free()
			var mouse_pos=get_global_mouse_position()
			var tile_pos=tMap.local_to_map(mouse_pos)
			if not GameManager.tile_ocupada(tile_pos):
				if is_ghost_outside==false:
					place_plant(tile_pos)
			is_pressed=false
		get_tree().call_group("map","esta_presionado",is_pressed)
	pass


func place_plant(tile_pos):
	var plant_instance = another_plant_scene.instantiate()
	plant_instance.tile_pos=tile_pos
	var world_pos=tMap.map_to_local(tile_pos)
	plant_instance.position=world_pos
	if GameManager._on_money_collected(price)=="rechazado":
		return
	$Panel.visible=true
	get_parent().get_parent().add_child(plant_instance)
	audio.play()
	GameManager.plant_placed(tile_pos)
	pass

func _on_button_pressed():
	if $Panel.is_visible_in_tree(): return
	if is_pressed: return
	var ghost=ghost_tipe.instantiate()
	get_parent().get_parent().add_child(ghost)
	is_pressed=true
	pass # Replace with function body.

func esta_posicionado_en_la_arena(is_outside):
	is_ghost_outside=is_outside
