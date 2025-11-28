class_name Inventory extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().paused = false
	self.hide()
	player.get_child(5).show()
	

func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("escape") :
		player.get_child(5).show()
		get_tree().paused = false

func add_item(item : item) -> void :
	
