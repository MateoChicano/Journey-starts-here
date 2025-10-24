class_name npc extends CharacterBody3D

@export var npc_name : String
@export var day_ident : String = "0"
@onready var loadDialog : Dictionary = DialogManager.loadDialog(npc_name)
@onready var player : Player = get_tree().get_first_node_in_group("Player")

var displayed_text : Label
var dialog_ident : int = 0


func _ready() -> void:
	get_child(3).hide()
	displayed_text = get_child(3).get_child(0)

func displayDialog() -> void :

	var char_max : int = len(get_node("Text_box/Dialog").text) + 1
	var delay : float = 0.02
	
	get_node("Text_box/Name").text = self.npc_name
	get_child(3).show()
	displayed_text.visible_characters = 0

	if dialog_ident < loadDialog["day"+day_ident].size() :
		displayed_text.text = loadDialog["day"+day_ident][dialog_ident]
		dialog_ident += 1
	else :
		displayed_text.text = loadDialog["day"+day_ident][dialog_ident-1]

	for i in range(char_max) :
		displayed_text.visible_characters = i
		await get_tree().create_timer(delay).timeout


func _on_text_box_click(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") :
			self.displayDialog()


func _on_text_box_hover() -> void:
	player.skip_move = true


func _off_text_box() -> void:
	player.skip_move = false
