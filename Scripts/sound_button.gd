extends Button
@onready var but_down = $"button down"
func _ready():
	if GameManager.but_pressed<0:
		but_down.visible=true
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),-100)
	else:
		but_down.visible=false
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),0)
	pass # Replace with function body.

func _on_pressed():
	GameManager.but_pressed*=-1
	if GameManager.but_pressed<0:
		but_down.visible=true
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),-100)
	else:
		but_down.visible=false
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),-4.3)
	pass # Replace with function body.
