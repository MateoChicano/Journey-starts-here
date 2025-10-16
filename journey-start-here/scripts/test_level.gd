extends Node3D

const load_pause_menu : PackedScene = preload("res://scenes/Menus/pause_menu.tscn")
var instance_pause : pause = load_pause_menu.instantiate()

func _ready() -> void:
	self.add_child(instance_pause)
	instance_pause.hide()

	
