class_name hud extends CanvasLayer

const INVENTORY : PackedScene = preload("res://scenes/Menus/inventory.tscn")
var is_mouse_on_hud : bool
var instance_inv : Node = INVENTORY.instantiate()
var skip_movement : bool = false


func _ready() -> void :
	self.add_child(instance_inv)
	instance_inv.hide()


func on_inventory_pressed() -> void:
	instance_inv.visible = !instance_inv.visible
	print("pressed")


func hover_inventory() -> void:
	skip_movement = true

func off_inventory() -> void:
	skip_movement = false
