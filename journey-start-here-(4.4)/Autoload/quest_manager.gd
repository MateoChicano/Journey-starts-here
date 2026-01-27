extends Node

var quests : Dictionary
var file : String

func load_quest(key : String) -> String :
	file = FileAccess.get_file_as_string("res://scripts/Menus/Hud/Quests.json")
	quests = JSON.parse_string(file)
	return quests[key]
