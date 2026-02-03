class_name Inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")

func quit_inventory() -> void:
	get_tree().paused = false
	self.hide()
	player.get_node("HUD").show()
	for body :Item in get_node("Items").get_children():
		body.just_spawned = false
		if body.is_in_container:
			body.grounded = false
			if body.instance_3d :
				body.instance_3d.queue_free()
			else : 
				body.can_make_3d = true
		else :
			if body.can_make_3d : 
				body.make_3d()
				body.can_make_3d = false
				player.inventory.get_node("Items").remove_child(body)
	
func _on_ground_touched(area:Area2D) -> void:
	if not area.owner.just_spawned and not area.owner.grounded :
		area.owner.grounded = true
