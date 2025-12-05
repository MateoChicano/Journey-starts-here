class_name quest_panel extends Control


@onready var displayed_desc : Label = self.get_node("Label")
@onready var selector_container : VBoxContainer = self.get_node("selectors")

var selectors : Array[Node]

func _ready() -> void:
	update_quests()

func get_quest(quest_name : String) -> void:
	displayed_desc.text = QuestManager.load_quest(quest_name)

func update_quests() -> void:
	for i in selector_container.get_children() :
		selectors.append(i)
		i.pressed.connect(_on_select_pressed.bind(i))


func _on_select_pressed(bouton : Button) -> void:
	get_quest(bouton.text)
