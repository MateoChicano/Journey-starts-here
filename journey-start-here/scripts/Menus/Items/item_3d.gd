class_name item_3d extends RigidBody3D

@export var nom : String
var item_2d : item
var just_spawned : bool

func get_item_2d() -> item :
	item_2d = load("res://scenes/Items/" + self.get_item_name()).instantiate()
	return item_2d

func get_item_name() -> String :
	return self.nom + ".tscn"
