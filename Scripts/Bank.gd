extends Area2D
@onready var marker = $Marker2D
@onready var timer = $Timer
@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	timer.start()
	set_process(false)
func _process(_delta):
	if anim_sprite.animation_finished:
		$wait_anim_time.start()
		set_process(false)
	pass
func _on_timer_timeout():
	var coin=preload("res://scenes/mecanics/Golden_coin.tscn").instantiate()
	anim_sprite.play("coin_spawned")
	set_process(true)
	get_parent().add_child(coin)
	coin.global_position= marker.global_position
	timer.start()
	timer.wait_time=18
	pass # Replace with function body.



func _on_wait_anim_time_timeout():
	anim_sprite.play("default")
	pass # Replace with function body.

func _level_finished():
	$Timer.stop()
