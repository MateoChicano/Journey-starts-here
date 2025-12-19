class_name Inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")



func quit_inventory() -> void:
	get_tree().paused = false
	self.hide()
	player.get_node("HUD").show()
	for i in get_node("Items").get_children():
		i.just_spawned = false
		if i.is_in_container:
			if not i.instance_3d :
				i.grounded = false
				return
			else :
				i.instance_3d.free()
				i.grounded = false
		else : 
			if not player.item_trigger_entered: 
				i.make_3d()
	

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		self.quit_inventory()

	
func _on_ground_touched(area:Area2D) -> void:
	if not area.owner.just_spawned and not area.owner.grounded :
		area.owner.grounded = true
