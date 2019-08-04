extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.death_count % 3 == 0:
		$IntroLabel.show()
	elif Global.death_count % 3 == 1:
		$ReloadLabel.show()
	elif Global.death_count % 3 == 2:
		$RackLabel.show()

func lose():
	$IntroLabel.hide()
	$ReloadLabel.hide()
	$RackLabel.hide()
	$Restart_Label.show()

func win():
	$WinLabel.show()