class_name npc extends CharacterBody3D

@export var npc_name : String = "name"
var dialog : String = 



func _ready() -> void:
	get_child(3).hide()
	get_node("Text_box/Dialog").text = self.dialog

func displayDialog() -> void :

	var char_max : int = len(get_node("Text_box/Dialog").text) + 1
	var delay : float = 0.02
	
	get_node("Text_box/Name").text = self.npc_name
	get_child(3).show()
	get_node("Text_box/Dialog").visible_characters = 0

	for i in range(char_max) :
		get_node("Text_box/Dialog").visible_characters = i
		await get_tree().create_timer(delay).timeout

