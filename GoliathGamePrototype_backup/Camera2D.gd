extends Camera2D

@export var player : CharacterBody2D

func _ready():
	offset.y = -64
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_down") or Input.is_action_pressed("down")):
		offset.y = 64
	else:
		offset.y = -64
