extends Node2D

func _ready():
	var levelInstance = get_parent().get_parent()
	levelInstance.connect("push_bullet", self, "push_bullet")
	levelInstance.connect("pop_bullet", self, "pop_bullet")

func push_bullet(bullet, pos):
	var tex = bullet.get_node("HUDIcon").texture
	
	var spr = Sprite.new()
	spr.texture = tex
	
	var tween = Tween.new()
	tween.set_name("tween")
	spr.add_child(tween)
	spr.position = -(get_viewport_rect().size - pos.get_origin())
	
	var tweenSize = Tween.new()
	tweenSize.set_name("tweenSize")
	spr.add_child(tweenSize)
	spr.set_scale(Vector2(0.5, 0.5))
	
	var count = get_child_count()
	if (count > 0):
		add_child_below_node(get_child(count - 1), spr)
	else:
		add_child(spr)

func pop_bullet(b, who):
	if (get_child_count() == 0):
		return
	var out = get_child(0)
	out.queue_free()

func _process(delta):
	var i = 1
	for c in get_children():
		var target_pos = Vector2(-c.texture.get_width(), -(i * c.texture.get_height()))
		c.get_node("tween").interpolate_method(c, "set_position", c.position, target_pos, 1.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
		c.get_node("tween").start()
		c.get_node("tweenSize").interpolate_method(c, "set_scale", c.scale, Vector2(1, 1), 1.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
		c.get_node("tweenSize").start()
		
		i += 1
