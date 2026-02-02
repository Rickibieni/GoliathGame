extends State

class_name LandingState

@export var ground_state : State

func on_enter():
	pass
func on_exit():
	pass

func state_process(delta):
	next_state = ground_state
	playback.travel("Move")
