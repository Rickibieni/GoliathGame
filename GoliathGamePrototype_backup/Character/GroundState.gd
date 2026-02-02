extends State

class_name GroundState

@export var jump_velocity : float = -300.0
@export var air_state : State
@export var attack_state : State
@export var combo_timer : Timer

func on_enter():
	pass
func on_exit():
	pass

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") or event.is_action_pressed("ui_up")):
		jump()
	if(event.is_action_pressed("space") || event.is_action_pressed("attack")):
		attack()

func jump():
	character.velocity.y = jump_velocity
	playback.travel("jump_start")
	
func state_process(delta):
	if(not character.is_on_floor()):
		next_state = air_state
	if("parameters/playback" != "Move"):
		playback.travel("Move")
func attack():
	combo_timer.start()
	next_state = attack_state
	attack_state.still_attacking = true
	playback.travel("attack")
