extends Area2D

export var speed = 2000
var velocity = Vector2()

func type():
	return "lethal"

func start(pos, dir):
	set_global_position(pos)
	rotation = dir
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.has_method("hit"):
		body.hit()
	visible = false
	$CollisionShape2D.queue_free()
	yield($AudioStreamPlayer2D, "finished")
	call_deferred("queue_free")
