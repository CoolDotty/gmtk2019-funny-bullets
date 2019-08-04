extends KinematicBody2D

signal killed

var crosshair = load("res://crosshair.png")

export (PackedScene) var Lethal
export (PackedScene) var Fake

onready var Casing = preload("res://Casing.tscn")

const speed = 500;
onready var clipazine = get_parent()
onready var Gun = $Gun
onready var dead = false

func _ready():
	Input.set_custom_mouse_cursor(crosshair)
	Gun.clipazine = clipazine

func get_input():
	var velocity = Vector2()
	
	if Input.is_action_just_pressed('ui_fire'):
		var out = Gun.shoot()
		if typeof(out) == TYPE_OBJECT:
			var tex = out.get_node("HUDIcon").texture
			var c = Casing.instance()
			c.create(tex, get_position());
			get_parent().add_child(c)
	
	if Input.is_action_just_pressed("ui_rack"):
		var out = Gun.rack()
		if out:
			var tex = out.get_node("HUDIcon").texture
			var c = Casing.instance()
			c.create(tex, get_position());
			get_parent().add_child(c)
		$SoundRack.play()
	
	if Input.is_action_just_pressed('ui_load_fake'):
		clipazine.push(Fake.instance(), self)
	
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
	if dead:
		return
	
	var velocity = get_input()
	var dir = get_global_mouse_position() - global_position
	rotation = dir.angle()
	velocity = move_and_slide(velocity)
	
func hit():
	if not dead:
		dead = true
		$CollisionShape2D.set_deferred("disabled", true)
		Global.death_count += 1
		# spawn dead guy
		emit_signal("killed")
		
		$SpriteGodude.visible = false
		$SpriteDead.visible = true
		
