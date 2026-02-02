extends State

class_name AirState

@export var landing_state : State
@export var ground_state : State
@export var double_jump_velocity : float = -300.0

var has_second_jump = true

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state
	if(character.velocity.y > 0):
		playback.travel("jump_end")
	else:
		playback.travel("jump_start")

func state_input(event : InputEvent):
	if((event.is_action_pressed("jump") or event.is_action_pressed("ui_up")) and has_second_jump and character.has_double_jump):
		double_jump()

func on_exit():
	if(next_state == landing_state):
		has_second_jump = true

func double_jump():
	character.velocity.y = double_jump_velocity
	has_second_jump = false

func on_enter():
	pass
