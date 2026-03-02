class_name Item_3d extends RigidBody3D

@onready var context_menu : Node = self.get_node("ContextMenu")
@onready var player : Node = get_tree().get_first_node_in_group("Player")
@export var nom : String
var item_2d : Item
var just_spawned : bool

func _ready() -> void :
	hideContext()

func get_item_2d() -> Item :
	item_2d = load(self.get_item_path()).instantiate()
	return item_2d

func get_item_name() -> String :
	return self.nom

func get_item_path() -> String :
	return "res://Entities/Items/2Ds/" + self.get_item_name() + "/" + self.get_item_name() + ".tscn"

func showContext() -> void :
	self.get_node("ContextMenu").position = get_viewport().get_mouse_position()
	for buttons in self.get_node("ContextMenu").get_children():
		buttons.show()

func hideContext() -> void :
	for buttons in self.get_node("ContextMenu").get_children():
		buttons.hide()
	
func _on_take_pressed() -> void:
	player.go_and_take(self)
	hideContext()
