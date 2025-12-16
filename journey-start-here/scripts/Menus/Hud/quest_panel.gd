class_name quest_panel extends Control

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var displayed_desc : Label = self.get_node("Label")
@onready var selector_container : VBoxContainer = self.get_node("selectors")
@onready var completed_container : VBoxContainer = self.get_node("selectors/completed")

var selectors : Array[Node]

func _ready() -> void:
	self.mouse_entered.connect(hover_ui)
	self.mouse_exited.connect(off_ui)
	update_quests()

func get_quest(quest_name : String) -> void:
	displayed_desc.text = QuestManager.load_quest(quest_name)

func update_quests() -> void:
	for i in selector_container.get_children() :
		selectors.append(i)
		i.pressed.connect(_on_select_pressed.bind(i))


func _on_select_pressed(bouton : Button) -> void:
	get_quest(bouton.text)

func add_quest(quest_name : String) -> void :
	var new_quest : Button = Button.new()
	new_quest.text = quest_name
	selector_container.add_child(new_quest)

func complete_quest(quest_name : String) -> void :
	selector_container.remove_child(get_node(quest_name))
	completed_container.add_quest(quest_name)

#ui_element

func hover_ui() -> void:
	player.skip_rayQuery = true


func off_ui() -> void:
	player.skip_rayQuery = false
