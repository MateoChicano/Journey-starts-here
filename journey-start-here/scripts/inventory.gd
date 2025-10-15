class_name inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")
	

func off_inventory_panel() -> void:
	player.skip_move = false
	print(player.skip_move)


func hover_inventory_panel() -> void:
	player.skip_move = true
	print(player.skip_move)
