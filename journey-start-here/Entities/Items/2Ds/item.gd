class_name Item extends RigidBody2D

@export var item_name : String
@export var item_description : String
@export var item_shape : String
@onready var player :Player = get_tree().get_first_node_in_group("Player")

const TAILLE_MAX_POS : int = 6
var mouse_left_down: bool = false
var mouse_pos : Vector2
var mouse_force : float = 15
var instance_3d : Item_3d
var previous_pos : Vector2
var is_body_entered : bool
var is_in_container : bool
var just_spawned : bool
var grounded : bool
var move : bool
var can_make_3d : bool
var positions : Array[Vector2]

func _input( event:InputEvent ) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			mouse_left_down = true
			if is_body_entered  :
				move = true
				self.gravity_scale = 0
				self.linear_velocity.x = 0
				self.linear_velocity.y = 0
			

		elif event.button_index == 1 and not event.is_pressed():
			if move == true :
				self.linear_velocity = sum(positions) / positions.size() * mouse_force
				self.gravity_scale = 1.0
				mouse_left_down = false	
				move = false
			if is_body_entered == false :
				move = false
			mouse_left_down = false		
			
func _physics_process(_delta: float) -> void:
	positions.append(mouse_pos - global_position)

	if positions.size() >= TAILLE_MAX_POS :
		positions.remove_at(0)
	if mouse_left_down and move:
		mouse_pos = get_viewport().get_mouse_position()
		self.linear_velocity = (mouse_pos-global_position)*mouse_force

func sum(tableau : Array[Vector2]) -> Vector2 :
	var resultat : Vector2
	for i in tableau :
		resultat.x += i.x
		resultat.y += i.y
	return resultat

func _on_exited_container(_area:Area2D) -> void:
	is_in_container = false


func _on_entered_container(_area:Area2D) -> void:
	is_in_container = true

func make_3d() -> void :
	if item_shape == "carre" :
		instance_3d = preload("res://Entities/Items/3Ds/item_box_3d.tscn").instantiate()
		instance_3d.nom = item_name
		instance_3d.just_spawned = true
		instance_3d.item_2d = self
		var offset : Vector3 = Vector3(2,2,2)
		player.get_parent().add_child(instance_3d)
		
		instance_3d.global_position = player.global_position + offset

#Getters
func get_item_name() -> String :
	return item_name
