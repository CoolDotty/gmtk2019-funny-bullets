extends Node

signal push_bullet
signal push_bullet_front
signal pop_bullet

var clipazine = [];

func _ready():
	pass

# Returns an instance of a bullet or Null
func pop(who):
	var b = clipazine.pop_front()
	emit_signal("pop_bullet", b, who)
	return b

func peek():
	if not clipazine.empty():
		return clipazine[0]
	return null

func push(bullet_instance): # instance of scene
	emit_signal("push_bullet", bullet_instance)
	clipazine.push_back(bullet_instance)

func empty():
	return clipazine.empty()

func game_over():
	pass