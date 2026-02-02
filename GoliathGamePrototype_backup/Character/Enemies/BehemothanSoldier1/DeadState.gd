extends State

func _ready():
	can_move = false
	
func on_enter():
	playback.travel("dead")
	can_move = false
	character.velocity.x = 0
