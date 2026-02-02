extends Node

class_name State

@export var can_move : bool = true

var character : CharacterBody2D
var next_state : State
var playback : AnimationNodeStateMachinePlayback

signal interrupt_state(new_state : State)

func state_process(delta):
	pass

func state_input(event):
	pass

func on_enter():
	pass

func on_exit():
	pass
