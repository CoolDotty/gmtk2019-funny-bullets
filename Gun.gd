extends Node2D

export (NodePath) var MuzzlePath

export var pump_delay = 1;

onready var chamber = null
onready var timer = $Timer
onready var muzzle = get_node(MuzzlePath)
var clipazine

enum {MAGAZINE_EMPTY, ALREADY_RACKING, STARTED_RACKING}

func _ready():
	pass # Replace with function body.

# returns whether a bullet was fired
func shoot() -> bool:
	if chamber and timer.time_left == 0:
		chamber.start(muzzle.global_position, get_parent().rotation)
		clipazine.add_child(chamber)
		
		chamber = null
		return true
	else:
		return false

# returns whether attempting to load a shell succeeded (magazine is empty)
func rack():
	if timer.time_left == 0:
		if chamber:
			chamber.queue_free()
		
		chamber = clipazine.pop(self)
		if not chamber:
			return MAGAZINE_EMPTY
		
		timer.set_wait_time(pump_delay)
		timer.start()
		
		return STARTED_RACKING
	else:
		return ALREADY_RACKING
