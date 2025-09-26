extends Button
var load_scene = "res://scenes/levels/main.tscn"


func _on_pressed() -> void:
	get_tree().change_scene_to_file(load_scene)
