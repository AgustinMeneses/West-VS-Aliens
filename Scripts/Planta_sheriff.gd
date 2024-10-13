extends Area2D
class_name Tower
@onready var sprite = $sprite
@onready var anim = $AnimationPlayer
@export var life:int=30
var tile_pos:Vector2
var enemies: Array[Enemy]=[]
var can_shoot:bool=true
var bullet_scene = load("res://scenes/objects/bala.tscn") as PackedScene
var tMap:TileMap = preload("res://scenes/mecanics/map.tscn").instantiate()

func _ready():
	add_to_group("plantas")
	#_ajustar_collision_shape()
	$AnimationPlayer.play("start")
	$Atack_area.area_entered.connect(_on_enemy_entered)
	$Atack_area.area_exited.connect(_on_enemy_exited)
	can_shoot=false
	$Shoot_Timer.start()
	pass

func _on_enemy_entered(enemy:Enemy):
	enemies.append(enemy)
	_atack_enemy()
	pass

func _on_enemy_exited(enemy:Enemy):
	enemies.erase(enemy)
	pass

func _atack_enemy():

	if not can_shoot==true: 
		return
	if enemies.is_empty(): 
		return
	var enemy:Enemy=enemies.front()
	anim.play("shooting")
	can_shoot=false
	var direction_to_enemies=global_position.direction_to(enemy.global_position)
	var bullet : Bullets= bullet_scene.instantiate()
	add_child(bullet)
	bullet.call_deferred("set_global_position", $"sprite/pistola 1/Marker_1".global_position)
	bullet.set_direction(direction_to_enemies)
	await get_tree().create_timer(0.3).timeout
	var bullet_2 : Bullets= bullet_scene.instantiate()
	add_child(bullet_2)
	bullet_2.call_deferred("set_global_position", $"sprite/Pistola 2/Marker_2".global_position)
	if enemy or enemy.is_inside_tree():
		bullet_2.set_direction(direction_to_enemies)
	$Shoot_Timer.start()

func _on_shoot_timer_timeout():
	can_shoot=true
	if not enemies.is_empty():
		_atack_enemy()
	else:
		anim.play("IDLE")
	pass # Replace with function body.

func _take_damage(atk:int,_area):
	life-=atk
	if life<=0:
		GameManager.plant_destroyed(tile_pos)
		queue_free()
		pass
	sprite.modulate=Color(1.5,1.5,1.5,1)
	$anim_damage.start()
	pass

func _on_anim_damage_timeout():
	sprite.modulate=Color(1,1,1)
	pass # Replace with function body.
