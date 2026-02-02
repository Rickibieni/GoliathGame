extends CharacterBody2D

class_name Player

# <Character Attributes>
@export var speed : float = 250.0

# Variables
var direction : float = 0.0
var is_direction_locked : bool = false
var is_moving : bool = false

# Unlock Abilities
@export var has_double_jump : bool = true
@export var is_stable_pose : bool = false
@export var has_double_strike : bool = true

# Instances
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	sprite.flip_h = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right") if(Input.get_axis("ui_left", "ui_right")==0) else Input.get_axis("ui_left", "ui_right")
	if(state_machine.is_movable() and direction != 0):
		is_moving = true
	else:
		is_moving = false
	
	if direction:
		velocity.x = direction * speed
		emit_signal("facing_direction_changed", sprite.flip_h)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	update_animation()
	update_facing_direction()
	move_and_slide()
	
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction)
	#if direction != 0:
		#animated_sprite.play("run")
	#else:
		#animated_sprite.play("idle")
	#if(Input.is_action_pressed("ui_down") or Input.is_action_pressed("down")):
		#animated_sprite.play("jump_end")
	#if velocity.y > 0:
		#animated_sprite.play("jump_end")
	#elif velocity.y < 0:
		#animated_sprite.play("jump_start")
	#if(Input.is_action_just_pressed("attack")):
		#animated_sprite.play("attack")
		#await $AnimatedSprite2D

func update_facing_direction():
	if(!is_direction_locked):
		if direction > 0:
			sprite.flip_h = true
		elif direction < 0:
			sprite.flip_h = false
