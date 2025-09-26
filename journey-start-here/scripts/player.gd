extends CharacterBody3D

const step = 4
const rayLength = 100
var cam
@onready var navAgent := $NavigationAgent3D
	
func enter_trigger(area : Area3D) -> void:
	cam = area.get_child(1)
	cam.make_current()
	
func _input(_event:InputEvent):
	if Input.is_action_just_pressed("left_click") :
		var mousePos = get_viewport().get_mouse_position()
		var from = cam.project_ray_origin(mousePos)
		var to = from + cam.project_ray_normal(mousePos) * rayLength
		var space = get_world_3d().direct_space_state
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = from
		rayQuery.to = to
		var res = space.intersect_ray(rayQuery)
		
