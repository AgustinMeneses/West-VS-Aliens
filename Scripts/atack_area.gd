extends Area2D

signal enemy_entered(enemy)
signal enemy_exited(enemy)

func _on_area_entered(_area: Area2D):
	var enemy : Enemy = _area.get_parent() as Enemy
	enemy_entered.emit(enemy)
	pass # Replace with function body.

func _on_area_exited(_area: Area2D):
	var enemy : Enemy = _area.get_parent() as Enemy
	enemy_exited.emit(enemy)
	pass # Replace with function body.
