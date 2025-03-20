extends Node


var player

# travel, combat
var state:String = "travel"





func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	if player.enemies:
		state = "combat"
	else:
		state = "travel"
