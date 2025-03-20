extends CharacterBody3D


var input

var max_speed: int = 5
var current_speed:float = 0.0
var acceleration: float = 0.4

var input_vec:Vector2 = Vector2(0,0)
var inp_vec3:Vector3 = Vector3(0,0,0)
var mov_vec:Vector3 = Vector3(0,0,0)


var enemies:Array = []



func _ready() -> void:
	input = get_tree().get_first_node_in_group("Input")


func _process(delta: float) -> void:
	input_vec = Vector2(0,0)
	
	### Right inputs
	match input.r_state:
		"drag":
			drag_right()
		"swipe":
			print("swipe r")
		"touch":
			print("touch r")
	
	
	### Left inputs
	match input.l_state:
		"drag":
			drag_left()
		"swipe":
			print("swipe l")
		"touch":
			print("touch l")


func _physics_process(delta: float) -> void:
	inp_vec3 = Vector3(input_vec.x, 0, input_vec.y)
	mov_vec = mov_vec.move_toward(inp_vec3 * max_speed, acceleration)
	velocity = mov_vec
	move_and_slide()


func drag_left():
	$Rotate.rotation.y = input.l_dir.angle_to(Vector2(0,1))

func swipe_left():
	pass

func touch_left():
	pass


func drag_right():
	input_vec = input.r_dir
	$Rotate.rotation.y = input.r_dir.angle_to(Vector2(0,1))

func swipe_right():
	pass

func touch_right():
	pass



func _on_enemy_det_body_entered(body: Node3D) -> void:
	if not body in enemies:
		enemies.append(body)


func _on_enemy_det_body_exited(body: Node3D) -> void:
	if body in enemies:
		enemies.remove_at(enemies.find(body))
