extends Button


func _on_pressed() -> void :
	get_tree().paused = false
	owner.queue_free()


		
