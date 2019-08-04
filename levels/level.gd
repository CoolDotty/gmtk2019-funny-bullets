extends Node

signal push_bullet
signal pop_bullet

export (AudioStream) var sound_reload

var clipazine = [];

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed('ui_restart'):
		get_tree().reload_current_scene()

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
	
	var player = AudioStreamPlayer.new()
	player.stream = sound_reload
	add_child(player)
	player.play()
	yield(player, "finished")
	player.queue_free()

func empty():
	return clipazine.empty()

func game_over():
	for c in get_children():
		if c.has_method("stop"):
			c.stop()

func _on_player_killed():
	game_over()
