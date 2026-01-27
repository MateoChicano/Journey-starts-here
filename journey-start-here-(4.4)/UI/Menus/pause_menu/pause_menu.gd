class_name pause extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var HUD : hud = player.get_node("HUD")

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		quit_menu()

func _on_pressed() -> void:
	quit_menu()

func quit_menu() -> void :
	self.hide()
	get_tree().paused = false
