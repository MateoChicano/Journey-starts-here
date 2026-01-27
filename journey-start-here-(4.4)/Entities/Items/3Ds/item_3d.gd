class_name item_3d extends RigidBody3D

@export var nom : String
var item_2d : item
var just_spawned : bool

func get_item_2d() -> item :
	item_2d = load(self.get_item_path()).instantiate()
	return item_2d

func get_item_name() -> String :
	return self.nom

func get_item_path() -> String :
	return "res://Entities/Items/2Ds/" + self.get_item_name() + "/" + self.get_item_name() + ".tscn"
