class_name item_3d extends RigidBody3D

@export var nom : String
@onready var item_2d : item = load("res://scenes/Items/" + self.get_item_name()).instantiate()

func get_item_name() -> String :
    return self.nom + ".tscn"

func get_item() -> item :
    return item_2d
