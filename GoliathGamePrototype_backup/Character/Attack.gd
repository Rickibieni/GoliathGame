extends State

@export var return_state : State
@onready var timer : Timer = $Timer
var still_attacking : bool = false
var current_direction = 1

func state_input(event : InputEvent):
	if((event.is_action_pressed("space") || event.is_action_pressed("attack")) and !timer.is_stopped() and character.has_double_strike):
		playback.travel("attack2")
		still_attacking = true

func state_process(delta):
	if((timer.is_stopped() and !still_attacking)):
		playback.travel("Move")
		next_state = return_state

func on_enter():
	character.is_direction_locked = true
	#can_move = !character.is_stable_pose
	#current_direction = character.direction

func on_exit():
	character.is_direction_locked = false

func _on_animation_tree_animation_finished(anim_name):
	still_attacking = false
	if(anim_name == "attack"):
		playback.travel("Move")
		if(!character.has_double_strike):
			next_state = return_state
		
	if(anim_name == "attack2"):
		playback.travel("Move")
		next_state = return_state
