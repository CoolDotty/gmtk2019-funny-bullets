extends Node2D

onready var tp = $tween_position
onready var tr = $tween_rotation

const EJECT_DISTANCE = 150

var target

func _ready():
	pass

func create(sprite, pos):
	$Sprite.texture = sprite
	$Sprite.scale = Vector2(0.25, 0.25)
	position = pos
	target = pos + Vector2(randf() * EJECT_DISTANCE - (EJECT_DISTANCE / 2), randf() * EJECT_DISTANCE - (EJECT_DISTANCE / 2))

func _process(delta):
	tp.interpolate_property(self, "position", get_position(), target, 1.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tp.start()
	tr.interpolate_property(self, "rotation", get_rotation(), 0, 1.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tr.start()
