extends Node3D

@onready var player : Player = get_tree().get_first_node_in_group("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if player.navAgent.get_next_path_position() != null :
		self.position = player.navAgent.get_next_path_position()
