extends Node2D

func _ready():
	var levelInstance = get_parent().get_parent()
	levelInstance.connect("push_bullet", self, "push_bullet")
	levelInstance.connect("push_bullet_front", self, "push_bullet_front")
	levelInstance.connect("pop_bullet", self, "pop_bullet")

func push_bullet(bullet):
	var tex = bullet.get_node("HUDIcon").texture
	
	var spr = Sprite.new()
	spr.texture = tex
	
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
		c.position.x = -c.texture.get_width()
		c.position.y = -(i * c.texture.get_height())
		i += 1
