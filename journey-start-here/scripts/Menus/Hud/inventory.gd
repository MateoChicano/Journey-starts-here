class_name Inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")



func _on_quit_pressed() -> void:
	get_tree().paused = false
	self.hide()
	player.get_node("HUD").show()
	for i in get_node("Items").get_children():
		i.just_spawned = false
		if i.is_in_container :
			i.dropped = false
		else :
			i.queue_free()
	

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		player.get_child(8).show()
		get_tree().paused = false

	
func _on_ground_touched(area:Area2D) -> void:
	if not area.owner.just_spawned and not area.owner.dropped :
		area.owner.dropped = true
		area.owner.make_3d()
