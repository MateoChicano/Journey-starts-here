class_name Inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var ground_area : CollisionShape2D = get_node("inventory_container/Ground_trigger/CollisionShape2D")
@onready var container_area : CollisionShape2D = get_node("inventory_container/item_container/CollisionShape2D")

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
			
			body.can_make_3d = true
		else :
			if body.can_make_3d : 
				body.make_3d()
				body.can_make_3d = false
				get_node("Items").remove_child(body)
	
func _on_ground_touched(area:Area2D) -> void:
	if not area.owner.just_spawned and not area.owner.grounded :
		area.owner.grounded = true

func item_in_container(item : Item, rect : Rect2) -> void :
	rect = container_area.shape.get_rect()
	var top_left : Vector2 = container_area.to_global(rect.position)
	var bottom_right : Vector2 = container_area.to_global(rect.position + rect.size)
	var x: float = randf_range(top_left.x, bottom_right.x)
	var y: float = randf_range(top_left.y, bottom_right.y)
	
	item.is_in_container = true
	item.can_make_3d = true
	item.just_spawned = false
	item.global_position = Vector2(x,y)

func pick_item(p_item: Item, context : bool = false) -> void:
	get_node("Items").add_child(p_item)
	player.HUD.inventory_notif.show()
	var rect : Rect2
	if (context) :
		if (p_item.instance_3d) :
			p_item.instance_3d.queue_free()
		item_in_container(p_item, rect)
	else :
		rect = ground_area.shape.get_rect()
		var x: float = randf_range(rect.position.x, rect.position.x + rect.size.x)
		var y: float = randf_range(rect.position.y, rect.position.y + rect.size.y)
		p_item.position = Vector2(x,y)

	
	player.from_context = false
