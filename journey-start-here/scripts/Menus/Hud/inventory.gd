class_name Inventory extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().paused = false
	self.hide()
	

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		get_tree().paused = false
		self.hide()
