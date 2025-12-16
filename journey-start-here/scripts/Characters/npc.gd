class_name npc extends CharacterBody3D

@export var npc_name : String
@export var day_ident : String = "0"
@export var attached_quest : String
@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var displayed_text : Label = get_node("Text_box/Dialog")
@onready var text_box : Panel = get_node("Text_box")

var dialog_finished : bool
var has_quest : bool
var visited : bool
var cptDialog : int = 0
var loadDialog : Dictionary


func _ready() -> void:
	text_box.hide()
	loadDialog = DialogManager.loadDialog(npc_name)
	if attached_quest != null :
		has_quest = true
	else :
		has_quest = false
	

func displayDialog() -> void :

	var delay : float = 0.02
	dialog_finished = false

	
	get_node("Text_box/Name").text = self.npc_name
	text_box.show()
	displayed_text.visible_characters = 0

	if cptDialog < loadDialog["day"+day_ident].size() :
		displayed_text.text = loadDialog["day"+day_ident][cptDialog] #recupere la ligne numéro cptDialog
		cptDialog += 1
	else :
		displayed_text.text = loadDialog["day"+day_ident][cptDialog-1] #recup la derniere ligne de dialogue
	var char_max : int = len(displayed_text.text) + 1

	for i in range(char_max) :
		displayed_text.visible_characters = i
		await get_tree().create_timer(delay).timeout
	if has_quest and not visited:
		player.HUD.get_node("menu container/general menu/Quest/HBoxContainer").add_quest(attached_quest)
		player.HUD.get_node("menu container/general menu/Quest/HBoxContainer").update_quests()
	visited = true
	dialog_finished = true

func _on_text_box_click(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") :
		if visited :
			if cptDialog == loadDialog["day"+day_ident].size():
				self.closeDialogBox()
			else :
				self.displayDialog()

func closeDialogBox() -> void :
	text_box.hide()
		
