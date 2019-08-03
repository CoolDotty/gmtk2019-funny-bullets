extends Node

signal push_bullet
signal pop_bullet

var clipazine = [];

func _ready():
	pass

# Returns an instance of a bullet or Null
func pop(who):
	var b = clipazine.pop_front()
	emit_signal("pop_bullet", b, who)
	return b

func push(bullet_instance): # instance of scene
	emit_signal("push_bullet", bullet_instance)
	clipazine.push_back(bullet_instance)

func empty():
	return clipazine.empty()
