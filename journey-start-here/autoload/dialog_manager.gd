extends Node

var dialogs : Dictionary
var file : String

func loadDialog(key : String) -> Dictionary :
	file = FileAccess.get_file_as_string("res://Entities/FriendlyNPC/Dialogs.json")
	dialogs = JSON.parse_string(file)
	return dialogs[key]
