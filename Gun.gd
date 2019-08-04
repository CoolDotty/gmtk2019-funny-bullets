extends Node2D

export (NodePath) var MuzzlePath

export var shoot_delay = 0.75;
export var reload_delay = 0.25;

onready var timer = $Timer
onready var muzzle = get_node(MuzzlePath)
var clipazine

enum {MAGAZINE_EMPTY, RACKING, SHOT, RELOADED}

func _ready():
	pass # Replace with function body.

# returns whether a bullet was fired
func shoot():
	if timer.time_left == 0:
		var chamber = clipazine.pop(self)
		timer.set_wait_time(shoot_delay)
		timer.start()
		if chamber:
			chamber.start(muzzle.global_position, get_parent().rotation)
			clipazine.add_child(chamber)
			
			var c = chamber
			chamber = null
			return c
		else:
			return MAGAZINE_EMPTY
	else:
		return RACKING

func reload(ammo):
	if timer.time_left == 0:
		clipazine.push(ammo.instance(), get_parent())
		timer.set_wait_time(reload_delay)
		timer.start()
		return RELOADED
	else:
		return RACKING

func rack():
	var out = clipazine.pop(self)
	if out:
		return out

func next_shot():
	return clipazine.peek()

func is_chambered():
	return not clipazine.empty()
	