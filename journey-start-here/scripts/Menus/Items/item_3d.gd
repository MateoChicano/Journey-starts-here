class_name item_3d extends RigidBody3D

@export var nom : String

func get_scene_name() -> String :
    return self.nom + ".tscn"
