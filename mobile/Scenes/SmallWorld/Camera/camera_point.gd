extends Node3D

var player
var towards:Vector3 = Vector3(0,0,0)
var cp_dis:float = 0


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	self.global_position = player.global_position
	$Camera3D.global_position = Vector3(0, 7, 5)
	$Camera3D.global_rotation_degrees = Vector3(-60, 0, 0)
	
func _physics_process(delta: float) -> void:
	cp_dis = self.global_position.distance_to(player.global_position) / 15
	towards = self.global_position.move_toward(player.global_position, cp_dis)
	self.global_position = towards
