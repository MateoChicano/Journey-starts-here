class_name hud extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var menu_gen : TabContainer = get_node("general menu")


func _ready() -> void :
	menu_gen.hide()

func on_inventory_pressed() -> void:
	if !menu_gen.visible :
		menu_gen.show()
	else :
		if menu_gen.current_tab == 0 :
			menu_gen.hide()
	menu_gen.current_tab = 0
	

func on_map_pressed() -> void:
	if !menu_gen.visible :
		menu_gen.show()
	else :
		if menu_gen.current_tab == 1 :
			menu_gen.hide()
	menu_gen.current_tab = 1

func hover_gui() -> void:
	player.skip_move = true

func off_gui() -> void:
	player.skip_move = false
