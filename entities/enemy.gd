extends KinematicBody2D

export (PackedScene) var AmmoType

onready var Player = $"../player"
onready var clipazine = get_parent()
onready var Gun = $Gun

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
	if Gun.is_chambered():
		Gun.shoot()
	else:
		Gun.reload(AmmoType)

func hit():
	queue_free()

