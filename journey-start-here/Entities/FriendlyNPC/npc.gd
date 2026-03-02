class_name Npc extends CharacterBody3D

@export var npc_name : String
@export var day_ident : String = "0"
@export var attached_quest_name : String
@export var completing_quest_name : String
@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var displayed_text : Label = get_node("Text_box/Dialog")
@onready var text_box : Panel = get_node("Text_box")
@onready var context_menu : Node = self.get_node("ContextMenu")
@onready var quests : HBoxContainer = player.HUD.quest

var dialog_finished : bool
var has_quest : bool
var visited : bool
var cptDialog : int = 0
var loadDialog : Dictionary
var attached_quest : Quest
var completing_quest : Quest
var dialog : Array


func _ready() -> void:
	hideContext()
	attached_quest = Quest.new(attached_quest_name)
	completing_quest = Quest.new(completing_quest_name)
	text_box.hide()
	loadDialog = DialogManager.loadDialog(npc_name)
	if attached_quest_name != "" :
		has_quest = true
	else :
		has_quest = false
	

func displayText(text : String) -> void :

	var delay : float = 0.02
	dialog_finished = false
	player.can_interact = false
	
	get_node("Text_box/Name").text = self.npc_name
	player.HUD.hide()
	text_box.show()
	displayed_text.visible_characters = 0
	displayed_text.text = text
	var char_max : int = len(displayed_text.text) + 1

	for i in range(char_max) :
		displayed_text.visible_characters = i
		await get_tree().create_timer(delay).timeout

	if has_quest and not visited:
		quests.add_quest(attached_quest_name)
		if attached_quest.get_quest_type() == "livraison" :
			player.inventory.pick_item(attached_quest.get_quest_item(), true) #Pas sur de ça
		quests.update_quests()

	for quest : String in quests.get_ongoing_quests() :
		if quest == completing_quest.get_name() :
			quests.complete_quest(completing_quest)

	visited = true
	dialog_finished = true
	player.can_interact = true

func displayDialog(key : String) -> void :
	dialog = loadDialog[key]
	displayText(dialog[cptDialog])
	cptDialog += 1
	
func _on_text_box_click(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") :
		if visited :
			if displayed_text.text == dialog[dialog.size()-1]:
				cptDialog = 0
				self.closeDialogBox()
			else :
				self.displayText(dialog[cptDialog])

func closeDialogBox() -> void :
	text_box.hide()
	player.HUD.show()
		
func _on_item_area_entered(area:Area3D) -> void:
	if area.owner is Item_3d : 
		if area.owner.get_item_name() == completing_quest.get_quest_item().get_item_name() :
			displayDialog("completed")
			quests.complete_quest(completing_quest_name)
			area.owner.queue_free()

func showContext() -> void :
	self.get_node("ContextMenu").position = get_viewport().get_mouse_position()
	for buttons in self.get_node("ContextMenu").get_children():

		buttons.show()
		if buttons.get_name() == "Give" :
			if not player.inventory.has_item(completing_quest.get_quest_item()):
				buttons.hide()

func hideContext() -> void :
	for buttons in self.get_node("ContextMenu").get_children():
		buttons.hide()

func _on_give_pressed() -> void:
	player.go_and_give(self)
	hideContext()


func _on_interact_pressed() -> void:
	player.go_and_interact(self)
	hideContext()
