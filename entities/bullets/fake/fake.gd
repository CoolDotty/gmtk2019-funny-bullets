extends Node2D

export var speed = 750
var velocity = Vector2()

func start(pos, dir):
	set_global_position(pos)
	rotation = dir
	velocity = Vector2(speed, 0).rotated(rotation)
	$Particles2D.emitting = true
	
	var t = Timer.new()
	t.set_wait_time($Particles2D.lifetime)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	remove_child(t)
	t.queue_free()
	
	queue_free()
