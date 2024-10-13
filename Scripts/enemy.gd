extends Area2D
class_name Enemy
@onready var anim: AnimationPlayer= $AnimationPlayer
@onready var anim_sprite = $AnimatedSprite2D
@onready var gpu_part= $AnimatedSprite2D/smoke/GPUParticles2D

@export var vel:float=-20
@export var life:int=40
@export var atk:int=5

signal plant_entered(plant)
signal plant_exited(plant)

var tMap:TileMap = preload("res://scenes/mecanics/map.tscn").instantiate()

var plant_front:bool=false
var can_atack:bool=true
var plants:Array=[]
var is_alive:bool=true

var sprite=null
var next_level=null


func _ready():
	add_to_group("enemies")
	anim.play("Idle")
	pass

func _process(delta):
	if plant_front==false:
		position.x+=delta*vel

func _take_damage(damage:int)->void:
	var spawn_aliens=get_parent()
	$hurt.play()
	life-=damage
	if life<=20:
		gpu_part.emitting=true
		pass
	if life<=0:
		if not damage>1000:
			GameManager._on_enemy_dead(self)
		anim.play("death")
		if damage>1000:
			is_alive=false
			set_process(false)
			await anim.animation_finished
			return
		var coin=preload("res://scenes/mecanics/Golden_coin.tscn").instantiate()
		coin.coin_value=25
		is_alive=false
		set_process(false)
		await anim.animation_finished
		if spawn_aliens.timer!=null:
			get_parent().add_child.call_deferred(coin)
			coin.global_position=$CoinMarker.global_position
			queue_free()
	anim_sprite.modulate=Color(1.5,1.5,1.5,1)
	$Timer.start()


func _on_atack_area_area_entered(_area:Area2D):
	plants.append(_area)
	_atack_plant()
	plant_front=true
	pass # Replace with function body.


func _on_atack_area_area_exited(_area):
	anim_sprite.play("default")
	anim.play("Idle")
	plants.erase(_area)
	plant_front=false
	pass # Replace with function body.

func _atack_plant():
	if not is_alive:return
	if plants.is_empty(): return
	if not can_atack: return
	can_atack=false
	anim.play("attacking")
	$Attack_cooldown.start()
	$Atack_timer.start()
	pass


func _on_timer_timeout():
	anim_sprite.modulate=Color(1,1,1)
	pass # Replace with function body.


func _on_atack_timer_timeout():
	can_atack=true
	_atack_plant()
	pass # Replace with function body.


func _on_attack_cooldown_timeout():
	if not plants.is_empty() and is_alive:
		plants[0]._take_damage(atk,plants[0])
