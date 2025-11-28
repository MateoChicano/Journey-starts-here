class_name mouse_area extends Area2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	self.global_position = get_viewport().get_mouse_position()
 

func _on_area_entered(area:Area2D) -> void:
	if area.get_parent() is RigidBody2D :
		area.get_parent().is_body_entered = true


func _on_area_exited(area:Area2D) -> void:
	if area.get_parent() is RigidBody2D :
		area.get_parent().is_body_entered = false
