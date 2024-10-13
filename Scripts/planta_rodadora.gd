extends Area2D
@onready var sprite = $sprite
@onready var shoot_timer = $Shoot_Timer
@onready var anim = $AnimationPlayer
var tMap:TileMap = preload("res://scenes/mecanics/map.tscn").instantiate()

@export var life:int=30
var tile_pos:Vector2
var enemies: Array[Enemy]=[]
var can_shoot:bool=true
var bullet_scene = load("res://scenes/objects/bala.tscn") as PackedScene

func _ready():
	add_to_group("plantas")
	$GPUParticles2D.restart()
	$Atack_area.area_entered.connect(_on_enemy_entered)
	$Atack_area.area_exited.connect(_on_enemy_exited)
	can_shoot=false
	shoot_timer.start()
	pass

func _on_enemy_entered(enemy:Enemy):
	enemies.append(enemy)
	_atack_enemy()
	pass

func _on_enemy_exited(enemy:Enemy):
	enemies.erase(enemy)
	pass

func _atack_enemy():
	if not $shooting.finished: return
	if not can_shoot==true: return
	if enemies.is_empty(): return
	var enemy:Enemy=enemies.front()
	anim.play("shooting")
	await get_tree().create_timer(0.12).timeout
	$shooting.play()
	can_shoot=false
	var bullet : Bullets= bullet_scene.instantiate()
	add_child.call_deferred(bullet)
	bullet.call_deferred("set_global_position", $sprite/pistola/Marker2D.global_position)
	bullet.set_direction(global_position.direction_to(enemy.global_position))
	shoot_timer.start()

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
