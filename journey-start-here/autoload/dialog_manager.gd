extends Node

var dialogs : Dictionary
var file : String
var dialog_ident : int

func loadDialog(key : String) -> Dictionary :
	file = FileAccess.get_file_as_string("res://scripts/Characters/Dialogs.json")
	dialogs = JSON.parse_string(file)
	return dialogs[key]
