extends PathFollow2D
@export var speed:int=70

@onready var t_coins = $"timing coins"

var is_spawned:bool=false


# Called when the node enters the scene tree for the first time.
func _ready():
	t_coins.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta:float):
	progress+=delta*speed

func _on_timing_coins_timeout():
	var coin=preload("res://scenes/mecanics/Golden_coin.tscn").instantiate()
	get_parent().add_child(coin)
	coin.global_position=$Marker2D.global_position
	t_coins.start()
	pass # Replace with function body.

