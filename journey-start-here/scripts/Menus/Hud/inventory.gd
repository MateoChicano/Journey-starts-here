class_name Inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")



func _on_quit_pressed() -> void:
	get_tree().paused = false
	self.hide()
	player.get_node("HUD").show()
	

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		player.get_child(8).show()
		get_tree().paused = false

	
