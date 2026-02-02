extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
var playback : AnimationNodeStateMachinePlayback

@export var is_flipped : bool
@export var sprite : Sprite2D
@export var movement_speed : float = 30.0
@export var hit_state : State
var is_chasing = false
@onready var dead_state = $CharacterStateMachine/Dead

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
var player
var direction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true
	playback = animation_tree["parameters/playback"]
	sprite.flip_h = is_flipped

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 1.5

	#var direction : Vector2 = starting_move_direction
	#if direction && state_machine.is_movable():
		#velocity.x = direction.x * movement_speed
	#elif state_machine.current_state != hit_state:
		#velocity.x = move_toward(velocity.x, 0, movement_speed)
	if player != null:
		direction = player.position - self.position
	else:
		direction = Vector2.ZERO
	if direction == Vector2.ZERO:
		playback.travel("idle")
	if is_chasing and state_machine.is_movable():
		playback.travel("walk")
		if direction.x > 1:
			sprite.flip_h = false
			velocity.x = sign(direction.x) * movement_speed
		elif direction.x < -1:
			sprite.flip_h = true
			velocity.x = sign(direction.x) * movement_speed
		else:
			velocity.x = 0

	if velocity.x == 0 and !is_chasing and state_machine.current_state != dead_state:
		playback.travel("idle")

	move_and_slide()

func _on_player_detection_body_entered(body):
	if(body.name == "Player"):
		player = get_node(body.get_path())
		is_chasing = true
		print(player.global_position)
		

func _on_player_detection_body_exited(body):
	if(body.name == "Player"):
		is_chasing = false
		velocity.x = 0
