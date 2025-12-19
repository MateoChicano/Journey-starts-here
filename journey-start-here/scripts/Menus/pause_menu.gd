class_name pause extends Control

@onready var HUD : hud = get_tree().get_first_node_in_group("HUD")

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		quit_menu()

func _on_pressed() -> void:
	quit_menu()

func quit_menu() -> void :
	get_tree().paused = false
	call_deferred("queue_free")
