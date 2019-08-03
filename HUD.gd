extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func stop():
	if Global.death_count == 1:
		$Load_Fake_Label.visible = true
	elif Global.death_count == 2:
		$Shoot_Label.visible = true
	elif Global.death_count == 3:
		$Rack_Label.visible = true
	else:
		$Restart_Label.visible = true
