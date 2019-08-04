extends Node

signal push_bullet
signal pop_bullet

export (AudioStream) var sound_reload

var enemy_count = 0
var clipazine = []

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

func push(bullet_instance, who): # instance of scene
	emit_signal("push_bullet", bullet_instance, who.get_global_transform_with_canvas())
	clipazine.push_back(bullet_instance)
	
	var player = AudioStreamPlayer.new()
	player.stream = sound_reload
	add_child(player)
	player.play()
	yield(player, "finished")
	player.queue_free()

func empty():
	return clipazine.empty()

func check_win():
	if enemy_count <= 0:
		win()

func win():
	stop_children()
	call_on_all_children("win")

func game_over():
	stop_children()
	call_on_all_children("lose")

func stop_children():
	call_on_all_children("stop")

func call_on_all_children(fn):
	for c in get_children():
		if c.has_method(fn):
			funcref(c, fn).call_func()

func _on_player_killed():
	game_over()
