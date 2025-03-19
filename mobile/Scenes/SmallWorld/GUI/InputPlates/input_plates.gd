extends Node2D


###TODO make touch, swipe and drag

### general
var drag_time: float = 0.15
var swipe_dis:int = 100

### Left plate variables
var timer_lt:float = 0.0
@onready var timer_l:Timer = $Left/TimerLeft
var pos_init_l:Vector2 = Vector2(0,0)
var pos_l:Vector2 = Vector2(0,0)
var pos_dis_l:int = 0
var drag_l:bool = false
var l_index:int = 0

var l_state = "none"


### Left plate variables
var timer_rt:float = 0.0
@onready var timer_r:Timer = $Right/TimerRight
var pos_init_r:Vector2 = Vector2(0,0)
var pos_r:Vector2 = Vector2(0,0)
var pos_dis_r:int = 0
var drag_r:bool = false
var r_index:int = 0

var r_state = "none"


var max_len = 300
#left plate outputs
var l_press = false
var l_dir:Vector2 = Vector2(0,0)
var l_strength: float = 0.0

#right plate outputs
var r_press = false
var r_dir:Vector2 = Vector2(0,0)
var r_strength: float = 0.0


func _process(delta: float) -> void:
	timer_lt = timer_l.time_left
	timer_rt = timer_r.time_left
	
	pos_dis_l = pos_init_l.distance_to(pos_l)
	pos_dis_r = pos_init_r.distance_to(pos_r)
	
	$LabelLeft.text = l_state
	$LabelRight.text = r_state
	
	
	#Resets
	l_strength = 0.0
	r_strength = 0.0
	
	##Parameters outputs
	#touch
	l_press = (l_state == "touch")
	r_press = (r_state == "touch")
	
	#swipe
	l_dir = Vector2(0,0)
	r_dir = Vector2(0,0)
	if l_state == "swipe":
		l_dir = pos_l - pos_init_l
		l_dir = l_dir.normalized()
	if r_state == "swipe":
		r_dir = pos_init_r - pos_r
		r_dir = r_dir.normalized()
		
	#drag
	if l_state == "drag": 
		l_dir = pos_l - pos_init_l
		l_dir = l_dir.normalized()
		l_strength = pos_init_l.distance_to(pos_l) / max_len
		l_strength = clamp(l_strength, 0.0, 1.0)
	if r_state == "drag": 
		r_dir = pos_r - pos_init_r
		r_dir = r_dir.normalized()
		r_strength = pos_init_r.distance_to(pos_r) / max_len
		r_strength = clamp(r_strength, 0.0, 1.0)
	
	##Part of setting left and right plates states	
	if l_state == "touch" or l_state == "swipe":
		l_state = "none"
	if r_state == "touch" or r_state == "swipe":
		r_state = "none"
	

	





func _on_left_plate_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		pos_l = event.position
	
	
	if event is InputEventScreenTouch:
		if event.pressed:
			l_index = event.index
			timer_l.start(drag_time)
			pos_init_l = event.position
			pos_l = event.position
			
		elif not event.pressed and l_index == event.index:
			if not drag_l:
				l_state = "touch"
				if drag_time - timer_lt > 0 and pos_dis_l > swipe_dis:
					l_state = "swipe"
			if l_state == "drag":
				l_state = "none"
			
			
			timer_l.stop()
			drag_l = false
			#pos_init_l = Vector2(0,0)
			#pos_l = Vector2(0,0)

func _on_timer_left_timeout() -> void:
	drag_l = true
	l_state = "drag"



func _on_right_plate_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		pos_r = event.position
	
	
	
	if event is InputEventScreenTouch:
		if event.pressed:
			r_index = event.index
			timer_r.start(drag_time)
			pos_init_r = event.position
			pos_r = event.position
			
		elif not event.pressed and r_index == event.index:
			if not drag_r:
				r_state = "touch"
				if drag_time - timer_rt > 0 and pos_dis_r > swipe_dis:
					r_state = "swipe"
			if r_state == "drag":
				r_state = "none"
			
			timer_r.stop()
			drag_r = false
			#pos_init_r = Vector2(0,0)
			#0pos_r = Vector2(0,0)

func _on_timer_right_timeout() -> void:
	drag_r = true
	r_state = "drag"
