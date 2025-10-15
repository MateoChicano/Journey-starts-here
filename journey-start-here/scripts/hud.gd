class_name hud extends Control

const INVENTORY : PackedScene = preload("res://scenes/Menus/inventory.tscn")
var is_mouse_on_hud : bool
var instance_inv : Node = INVENTORY.instantiate()

@onready var player : Player = get_tree().get_first_node_in_group("Player")


func _ready() -> void :
	self.add_child(instance_inv)
	instance_inv.hide()


func on_inventory_pressed() -> void:
	instance_inv.visible = !instance_inv.visible


func hover_inventory() -> void:
	player.skip_move = true
	print(player.skip_move)

func off_inventory() -> void:
	player.skip_move = false
	print(player.skip_move)
