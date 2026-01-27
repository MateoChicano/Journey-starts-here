class_name hud extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var contain_menu : Node = get_node("menu container")
@onready var menu_gen : TabContainer = contain_menu.get_node("general menu")
@onready var inventory : Inventory = player.get_node("Inventory")
@onready var notif_icon : Sprite2D = self.get_node("inventory toggle/notification")
@onready var quest : HBoxContainer = menu_gen.get_node("Quest/HBoxContainer")
	
func _ready() -> void :
	notif_icon.hide()

func on_inventory_pressed() -> void:
	self.hide()
	inventory.show()
	notif_icon.hide()

func on_map_pressed() -> void:
	if !contain_menu.visible :
		contain_menu.show()

func _on_quit_menu_pressed() -> void :
	contain_menu.hide()
