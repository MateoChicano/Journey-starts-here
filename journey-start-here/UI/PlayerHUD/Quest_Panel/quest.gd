class_name Quest extends HBoxContainer


@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var name_container : VBoxContainer = get_node("name_container")
@onready var desc_container : Panel = get_node("desc_container")
var quest_name : String
var quest_desc : String
var quest_type : String
var quest_item : Item

func _init(qname : String) -> void:
	if qname=="" :
		return

	self.quest_name = qname
	self.quest_desc = QuestManager.load_quest(qname)["desc"]
	self.quest_type = QuestManager.load_quest(qname)["type"]
	if self.quest_type == "livraison" :
		var item_name : String = QuestManager.load_quest(qname)["item"]
		var returned_item : Item = load("res://Entities/Items/2Ds/"+item_name+"/"+item_name+".tscn").instantiate()
		self.quest_item = returned_item
	else :
		quest_item = null

func add_quest() -> void :
	if quest_type == "livraison" :
		give_item()
	var new_title : Label = Label.new()
	var new_desc : Label = Label.new()
	new_title.text = name
	new_desc.text = self.get_quest_desc()
	name_container.add_child(new_title)
	desc_container.add_child(new_desc)

func get_quest_name() -> String :
	return quest_name

func get_quest_desc() -> String :
	return quest_desc

func get_quest_item() -> Item :
	return quest_item

func get_quest_type() -> String :
	return quest_type

func give_item() -> void :
	player.pick_item(self.get_quest_item())


#ui_element
func _ready() -> void:
	self.mouse_entered.connect(hover_ui)
	self.mouse_exited.connect(off_ui)

func hover_ui() -> void:
	player.skip_rayQuery = true


func off_ui() -> void:
	player.skip_rayQuery = false
