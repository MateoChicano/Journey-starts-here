extends HBoxContainer


@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var name_container : VBoxContainer = get_node("name_container")
@onready var desc_container : Panel = get_node("desc_container")
var quest_desc : String

func add_quest(quest_name : String) -> void :
	var new_title : Label = Label.new()
	var new_desc : Label = Label.new()
	new_title.text = quest_name
	new_desc.text = QuestManager.load_quest(quest_name)
	name_container.add_child(new_title)
	desc_container.add_child(new_desc)
	

#ui_element
func _ready() -> void:
	self.mouse_entered.connect(hover_ui)
	self.mouse_exited.connect(off_ui)

func hover_ui() -> void:
	player.skip_rayQuery = true


func off_ui() -> void:
	player.skip_rayQuery = false
