extends Area3D
var in_trigger = false

func enter_trigger(body) :
	if body.name == "player" :
		in_trigger = true
		
func exit_trigger(body) :
	if body.name == "player" :
		in_trigger = false

func _process(_delta: float) -> void:
	if in_trigger == true && get_parent().current != true :
		get_parent().make_current()
