extends Node3D

var pause_menu : PackedScene = preload("res://scenes/Menus/pause_menu.tscn")


func _input(_event:InputEvent) -> void:

	if Input.is_action_just_pressed("escape") :
		get_tree().paused = true
		var instance : Node = pause_menu.instantiate()
		self.add_child(instance)

	
