extends Control

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		self.quit_menu.call_deferred()
		

func quit_menu() -> void :
	get_tree().paused = false
	self.queue_free()

