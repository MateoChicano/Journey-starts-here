class_name Inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")



func quit_inventory() -> void:
	# var generated_item : item_3d
	get_tree().paused = false
	self.hide()
	player.get_node("HUD").show()
	for body :item in get_node("Items").get_children():
		body.just_spawned = false
		if body.is_in_container:
			if not body.instance_3d :
				body.grounded = false
				return
			else :
				body.instance_3d.free()
				body.grounded = false
		else : 
			if not player.item_trigger_entered: 
				body.make_3d()
				print(body)
				print(body.instance_3d)
				print(body.instance_3d.item_2d)
	
func _on_ground_touched(area:Area2D) -> void:
	if not area.owner.just_spawned and not area.owner.grounded :
		area.owner.grounded = true
