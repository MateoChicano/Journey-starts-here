class_name hud extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")

@onready var contain_menu : Node = get_node("menu container")
@onready var menu_gen : TabContainer = contain_menu.get_node("general menu")


func _ready() -> void :
	contain_menu.hide()
	menu_gen.show()

func on_inventory_pressed() -> void:
	if !contain_menu.visible :
		contain_menu.show()

	else :
		if menu_gen.current_tab == 0 :
			contain_menu.hide()
	menu_gen.current_tab = 0
	

func on_map_pressed() -> void:
	if !contain_menu.visible :
		contain_menu.show()
	else :
		if menu_gen.current_tab == 1 :
			contain_menu.hide()
	menu_gen.current_tab = 1

func _on_quit_menu_pressed() -> void :
	contain_menu.hide()
