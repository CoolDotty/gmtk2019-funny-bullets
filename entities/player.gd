extends KinematicBody2D

signal killed

export (PackedScene) var Lethal
export (PackedScene) var Fake

const speed = 500;
onready var clipazine = get_parent()
onready var Gun = $Gun

func _ready():
	Gun.clipazine = clipazine

func get_input():
	var velocity = Vector2()
	
	if Input.is_action_just_pressed('ui_fire'):
		Gun.shoot()
	
	if Input.is_action_just_pressed("ui_rack"):
		Gun.rack()
		$SoundRack.play()
	
	if Input.is_action_just_pressed('ui_load_fake'):
		clipazine.push(Fake.instance())
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	return velocity.normalized() * speed

func _physics_process(delta):
	var velocity = get_input()
	var dir = get_global_mouse_position() - global_position
	rotation = dir.angle()
	velocity = move_and_slide(velocity)
	
func hit():
	hide()  # Player disappears after being hit.
	emit_signal("killed")
	$CollisionShape2D.set_deferred("disabled", true)

func stop():
	# spawn dead guy
	queue_free()
