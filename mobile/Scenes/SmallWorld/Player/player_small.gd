extends CharacterBody3D


var input

var max_speed: int = 5
var current_speed:float = 0.0
var acceleration: float = 0.4

var input_vec:Vector2 = Vector2(0,0)
var inp_vec3:Vector3 = Vector3(0,0,0)
var mov_vec:Vector3 = Vector3(0,0,0)


func _ready() -> void:
	input = get_tree().get_first_node_in_group("Input")

func _process(delta: float) -> void:
	input_vec = Vector2(0,0)
	
	### Left inputs
	if input.r_state == "drag":
		input_vec = input.r_dir
	
	
	### Right inputs
	if input.l_state == "drag":
		$Rotate.rotation.y = input.l_dir.angle_to(Vector2(0,1))

func _physics_process(delta: float) -> void:
	inp_vec3 = Vector3(input_vec.x, 0, input_vec.y)
	mov_vec = mov_vec.move_toward(inp_vec3 * max_speed, acceleration)
	velocity = mov_vec
	move_and_slide()
