class_name UI_element extends Control

@onready var player: Player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	self.mouse_entered.connect(hover_ui)
	self.mouse_exited.connect(off_ui)

func hover_ui() -> void:
	player.skip_rayQuery = true


func off_ui() -> void:
	player.skip_rayQuery = false
