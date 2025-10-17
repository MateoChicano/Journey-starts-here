class_name pause extends Control

@onready var HUD : hud = get_tree().get_first_node_in_group("HUD")

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		if HUD.contain_menu.visible :
			HUD.contain_menu.hide()
		else :
			if get_tree().paused :
				self.quit_menu.call_deferred()
			else :
				get_tree().paused = true
				self.show()

func _on_pressed() -> void:
	get_tree().paused = false
	self.quit_menu.call_deferred()

func quit_menu() -> void :
	get_tree().paused = false
	self.hide()
