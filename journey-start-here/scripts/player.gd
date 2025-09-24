extends CharacterBody3D

func _process(delta: float) -> void:
	move()
	
func move() :
	position.z = position.z - 0.01
	
