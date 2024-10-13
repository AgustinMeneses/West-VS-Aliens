extends Control

@onready var money_label = $Money/money_Label
@onready var anim = $Money/AnimationPlayer
@onready var p_bar = $"progress bar/TextureProgressBar"

var value:int=0
var target_value:int=100
var money_initial:int=100
var first_time:bool=true


signal progress_completed(plant_bar)
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	add_to_group("UI")
	GameManager.no_money.connect(no_money)
	GameManager.update_money.connect(update_money)
	GameManager.update_progress_bar.connect(update_progress_bar)
	money_label.text = str(money_initial) + " $"
	pass # Replace with function body.

func update_money(money:int):
	money_label.text = str(money) + " $"
	first_time=false
	pass

func no_money(money:int):
	money_label.text = str(money) + " $"
	anim.play("out of money")

func update_progress_bar(kills:int):
	get_tree().call_group("levels","wait_timer_reduced",kills)
	p_bar.value=kills
	pass
