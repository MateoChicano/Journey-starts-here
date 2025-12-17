class_name quest_panel extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var displayed_desc : Label = self.get_node("Label")
@onready var ongoing_container : VBoxContainer = self.get_node("quest_titles/ongoing")
@onready var completed_container : VBoxContainer = self.get_node("quest_titles/completed")

var selectors : Array[Node]

func _ready() -> void:
	self.mouse_entered.connect(hover_ui)
	self.mouse_exited.connect(off_ui)
	update_quests()

func get_quest(quest_name : String) -> void:
	displayed_desc.text = QuestManager.load_quest(quest_name)

func update_quests() -> void:
	for i in ongoing_container.get_children() :
		selectors.append(i)
		i.pressed.connect(_on_select_pressed.bind(i))
	for i in completed_container.get_children() :
		if i.is_class("Label") :
			continue
		selectors.append(i)
		i.pressed.connect(_on_select_pressed.bind(i))
	

func get_ongoing_quests() -> Array :
	var quests : Array
	for i in ongoing_container.get_children() :
		quests.append(i.text)
	return quests

func get_completed_quests() -> Array :
	var quests : Array
	for i in completed_container.get_children() :
		if i.is_calss("Label"):
			continue
		quests.append(i.text)
	return quests

func _on_select_pressed(bouton : Button) -> void:
	get_quest(bouton.text)

func add_quest(quest_name : String) -> void :
	var new_quest : Button = Button.new()
	new_quest.text = quest_name
	ongoing_container.add_child(new_quest)


func complete_quest(quest_name : String) -> void :
	var new_quest : Button = Button.new()
	new_quest.text = quest_name
	completed_container.add_child(new_quest)
	for i : Button in ongoing_container.get_children():
		if i.text == quest_name :
			ongoing_container.remove_child(i)



#ui_element

func hover_ui() -> void:
	player.skip_rayQuery = true

func off_ui() -> void:
	player.skip_rayQuery = false
