extends Node2D

var bullets;

func _ready():
	var levelInstance = get_parent().get_parent()
	levelInstance.connect("push_bullet", self, "push_bullet")
	levelInstance.connect("pop_bullet", self, "pop_bullet")

func push_bullet(bullet):
	var tex = bullet.get_node("HUDIcon").texture
	
	var spr = Sprite.new()
	spr.texture = tex
	spr.position = Vector2(-tex.get_width(), tex.get_height() * get_child_count())
	add_child(spr)
	
	position -= Vector2(0, tex.get_height())

func pop_bullet(b, who):
	if (get_child_count() == 0):
		return
	var out = get_child(get_child_count() - 1)
	out.queue_free()
	position += Vector2(0, out.texture.get_height())
