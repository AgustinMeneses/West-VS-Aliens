extends CanvasLayer
@onready var rodadora_label = $"botones/Planta Rodadora/planta rodadora Label"
@onready var money_label = $botones/Panel/money_Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.update_money.connect(update_money)
	pass # Replace with function body.

func update_money(money:int):
	money_label.text = str(money) + " $"
	pass
