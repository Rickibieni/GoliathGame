extends Node

class_name Damageable
@export var state_machine : CharacterStateMachine
@export var dead_state : State

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var health : float = 150 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func hit(damage : int, knockback_direction : Vector2):
	if state_machine.current_state != dead_state:
		health -= damage
		emit_signal("on_hit", get_parent(), damage, knockback_direction)


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == "dead"):
		# character is finished dying, remove from the game
		get_parent().queue_free()
