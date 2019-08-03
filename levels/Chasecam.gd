extends Camera2D

export (NodePath) var Player

func _ready():
	global_position = get_node(Player).global_position;

func _process(delta):
	var target = get_node(Player).global_position;
	$Tween.interpolate_property(self, "global_position", get_global_position(), target, 1.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
