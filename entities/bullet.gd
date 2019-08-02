extends KinematicBody2D

export var speed = 750
var velocity = Vector2()

func start(pos, dir):
	set_global_position(pos)
	rotation = dir
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit()
		call_deferred("queue_free")

# func _on_VisibilityNotifier2D_screen_exited():
#  	queue_free()