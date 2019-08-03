extends KinematicBody2D

export (PackedScene) var AmmoType

onready var Player = $"../player"
onready var clipazine = get_parent()
onready var Gun = $Gun

var gun_has_my_ammo = false

func _ready():
	Gun.clipazine = clipazine

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var player_pos = Player.global_position
	var ignored = [self, Player]
	var intersected = space_state.intersect_ray(global_position, player_pos, ignored)
	
	if intersected.empty(): # We can see the player
		var dir = Player.global_position - global_position
		rotation = dir.angle()
		shoot()

func shoot():
	if gun_has_my_ammo:
		var bullet = Gun.next_shot()
		var shoot = Gun.shoot()
		if (shoot == Gun.SHOT):
			gun_has_my_ammo = false
	else:
		if Gun.reload(AmmoType) == Gun.RELOADED:
			gun_has_my_ammo = true

func hit():
	queue_free()

