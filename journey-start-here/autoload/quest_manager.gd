extends Node

var quests : Dictionary
var file : String

func load_quest(key : String) -> Dictionary :
	file = FileAccess.get_file_as_string("res://UI/PlayerHUD/Quest_Panel/Quests.json")
	quests = JSON.parse_string(file)
	return quests[key]
