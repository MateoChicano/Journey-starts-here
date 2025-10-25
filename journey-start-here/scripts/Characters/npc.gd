class_name npc extends CharacterBody3D

@export var npc_name : String
@export var day_ident : String = "0"
@onready var loadDialog : Dictionary = DialogManager.loadDialog(npc_name)
@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var displayed_text : Label = get_child(3).get_child(0)

var dialog_finished : bool
var cptDialog : int = 0


func _ready() -> void:
	get_child(3).hide() #cache la text box
	

func displayDialog() -> void :

	var delay : float = 0.02
	dialog_finished = false

	
	get_node("Text_box/Name").text = self.npc_name
	get_child(3).show() #montre la text box
	displayed_text.visible_characters = 0

	if cptDialog < loadDialog["day"+day_ident].size() :
		displayed_text.text = loadDialog["day"+day_ident][cptDialog] #recupere la ligne numéro cptDialog
		cptDialog += 1
	else :
		displayed_text.text = loadDialog["day"+day_ident][cptDialog-1] #recup la derniere ligne de dialogue
	var char_max : int = len(get_node("Text_box/Dialog").text) + 1

	for i in range(char_max) :
		displayed_text.visible_characters = i
		await get_tree().create_timer(delay).timeout
	dialog_finished = true

func _on_text_box_click(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") :
		if dialog_finished :
			if cptDialog == loadDialog["day"+day_ident].size():
				self.closeDialogBox()
			else :
				self.displayDialog()

func closeDialogBox() -> void :
	get_child(3).hide()
		
