class_name npc extends CharacterBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get_child(3).hide()
	displayDialog()

func displayDialog() -> void :
	var char_max : int = len(get_node("Text_box/Dialog").text)
	get_node("Text_box/Dialog").visible_characters = 0


	for i in range(char_max) :
		get_node("Text_box/Dialog").visible_characters = i
		wait()

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
