extends KinematicBody2D

export (PackedScene) var Bullet

signal hit

const speed = 1000;

func _ready():
	pass

func get_input():
	var velocity = Vector2()
	
	if Input.is_action_pressed('ui_left_click'):
		shoot()
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	return velocity.normalized() * speed

func shoot():
	# "Muzzle" is a Position2D placed at the barrel of the gun
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)

func _physics_process(delta):
	var velocity = get_input()
	var dir = get_global_mouse_position() - global_position
	rotation = dir.angle()
	velocity = move_and_slide(velocity)