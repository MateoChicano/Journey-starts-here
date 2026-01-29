class_name Hud extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var contain_menu : Node = get_node("menu container")
@onready var menu_gen : TabContainer = contain_menu.get_node("general menu")
@onready var inventory : Inventory = player.get_node("Inventory")
@onready var inventory_notif : Sprite2D = self.get_node("inventory toggle/inventory_notif")
@onready var book_notif : Sprite2D = self.get_node("book toggle/book_notif")
@onready var quest : HBoxContainer = menu_gen.get_node("Quest/HBoxContainer")
	
func _ready() -> void :
	inventory_notif.hide()
	book_notif.hide()

func on_inventory_pressed() -> void:
	self.hide()
	inventory.show()
	inventory_notif.hide()

func on_map_pressed() -> void:
	if !contain_menu.visible :
		contain_menu.show()
		book_notif.hide()

func _on_quit_menu_pressed() -> void :
	contain_menu.hide()
