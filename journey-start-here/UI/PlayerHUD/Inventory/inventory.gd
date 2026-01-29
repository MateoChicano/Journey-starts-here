class_name Inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")

func quit_inventory() -> void:
	
	get_tree().paused = false
	self.hide()
	player.get_node("HUD").show()
	for body :Item in get_node("Items").get_children():
		body.just_spawned = false
		if body.is_in_container:
			if not body.instance_3d :
				body.grounded = false
			else :
				body.instance_3d.queue_free()
				body.grounded = false
		else : 
			if not body.instance_3d : # renvoie true si instance_3d est null
				body.can_make_3d = true
			if body.can_make_3d : 
				body.make_3d()
				player.inventory.get_node("Items").remove_child(body)
	
func _on_ground_touched(area:Area2D) -> void:
	if not area.owner.just_spawned and not area.owner.grounded :
		area.owner.grounded = true
