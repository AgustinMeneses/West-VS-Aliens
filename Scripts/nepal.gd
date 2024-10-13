extends Area2D
var p_atk:int=3
var can_attack:bool=true
var currents_enemy:Array[Enemy]=[]
var tile_pos:Vector2

@export var life:int=75

@onready var sprite = $AnimatedSprite2D

@onready var shooter_timer = $shooter_timer
var ENEMY = preload("res://scenes/objects/enemy.tscn").instantiate()

func _ready():
	add_to_group("plantas")
	$AnimationPlayer.play("start")
	$Atack_area.area_entered.connect(_on_enemy_entered)
	$Atack_area.area_exited.connect(_on_enemy_exited)

func _on_enemy_entered(enemy:Enemy):
	currents_enemy.append(enemy)
	_attack_enemy()
	pass

func _on_enemy_exited(enemy:Enemy):
	currents_enemy.erase(enemy)
	pass

func _attack_enemy():
	if not can_attack: return
	if currents_enemy.is_empty():return
	can_attack=false
	for enemy in currents_enemy:
		enemy._take_damage(p_atk)
	shooter_timer.start()

func _take_damage(atk:int,_area):
	$hurt.play()
	life-=atk
	if life<=0:
		GameManager.plant_destroyed(tile_pos)
		queue_free()
	sprite.modulate=Color(1.5,1.5,1.5,1)
	$anim_damge.start()
	pass

func _on_shooter_timer_timeout():
	can_attack=true
	_attack_enemy()
	pass # Replace with function body.


func _on_anim_damge_timeout():
	sprite.modulate=Color(1,1,1)
	pass # Replace with function body.
