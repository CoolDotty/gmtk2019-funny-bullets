extends Node

onready var stopwatch = $Stopwatch/text

var start_time
var end_time
var ended = false

# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = OS.get_ticks_msec()
	if Global.death_count % 3 == 0:
		$IntroLabel.show()
	elif Global.death_count % 3 == 1:
		$ReloadLabel.show()
	elif Global.death_count % 3 == 2:
		$RackLabel.show()

func _process(delta):
	if ended:
		return
	end_time = OS.get_ticks_msec()
	var elapsed = end_time - start_time
	var millis = elapsed % 1000
	var seconds = (elapsed / 1000) % 60
	var minutes = min(elapsed / 60000, 99)
	var str_elapsed = "%02d:%02d:%02d" % [minutes, seconds, millis]
	stopwatch.text = str_elapsed

func lose():
	ended = true
	$IntroLabel.hide()
	$ReloadLabel.hide()
	$RackLabel.hide()
	$Restart_Label.show()

func win():
	ended = true
	$IntroLabel.hide()
	$ReloadLabel.hide()
	$RackLabel.hide()
	$WinLabel.show()