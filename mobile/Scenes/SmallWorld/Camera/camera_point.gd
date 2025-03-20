extends Node3D

var player
var director
var towards:Vector3 = Vector3(0,0,0)
var cp_dis:float = 0

#borders
var s_world_b: Node3D
var left_b
var right_b
var top_b
var down_b

# positions
var travel_p: Vector3 = Vector3(0,10,6)
var combat_p: Vector3 = Vector3(0,7,4)
var cam_dis:float = 0.0


func _ready() -> void:
	director = get_tree().get_first_node_in_group("Director")
	
	player = get_tree().get_first_node_in_group("Player")
	self.global_position = player.global_position
	$Camera3D.global_position = travel_p
	$Camera3D.global_rotation_degrees = Vector3(-60, 0, 0)
	
	s_world_b = get_tree().get_first_node_in_group("SmallWorld").get_node("Borders")
	#mozliwe ze pozniej te zmienic jesli bylyby mobilne
	left_b = s_world_b.get_node("Left").global_position
	right_b = s_world_b.get_node("Right").global_position
	top_b = s_world_b.get_node("Top").global_position
	down_b = s_world_b.get_node("Down").global_position
	
	
func _physics_process(delta: float) -> void:
	cp_dis = self.global_position.distance_to(player.global_position) / 15
	towards = self.global_position.move_toward(player.global_position, cp_dis)
	global_position = towards
	global_position.x = clamp(global_position.x, left_b.x, right_b.x)
	global_position.z = clamp(global_position.z, top_b.z, down_b.z)
	
	if director.state == "travel":
		cam_dis = $Camera3D.position.distance_to(travel_p) / 15
		$Camera3D.position = $Camera3D.position.move_toward(travel_p, cam_dis)
	elif director.state == "combat":
		cam_dis = $Camera3D.position.distance_to(combat_p) / 15
		$Camera3D.position = $Camera3D.position.move_toward(combat_p, cam_dis)
