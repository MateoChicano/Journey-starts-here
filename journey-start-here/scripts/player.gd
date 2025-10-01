extends CharacterBody3D

const SPEED : int = 4
const RAYLENGTH : int = 100
const GRAVITY : float = 4
var cam : Camera3D

@onready var navAgent := $NavigationAgent3D
	
	
func _physics_process(delta : float) -> void :
	if (navAgent.is_navigation_finished()) :
		return
	moveToPoint(delta)
			
func enter_trigger(area : Area3D) -> void:
	cam = area.get_child(1)
	cam.make_current()
	
func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") :

		var mousePos : Vector2 = get_viewport().get_mouse_position()
		var from : Vector3 = cam.project_ray_origin(mousePos)
		var to : Vector3= from + cam.project_ray_normal(mousePos) * RAYLENGTH
		var space : PhysicsDirectSpaceState3D= get_world_3d().direct_space_state
		var rayQuery : PhysicsRayQueryParameters3D= PhysicsRayQueryParameters3D.new()

		rayQuery.from = from
		rayQuery.to = to
		
		var res : Dictionary = space.intersect_ray(rayQuery)
		
		navAgent.set_target_position(res.position)

	if Input.is_action_just_pressed("escape"):
		self.get_tree().paused = !self.get_tree().paused
		get_tree().change_scene_to_file("res://scenes/pause_menu.tscn")

		
func moveToPoint(delta : float) -> void :
	var targetPos : Vector3 = navAgent.get_next_path_position()
	var direction : Vector3= global_position.direction_to(targetPos)
	velocity.x = direction.x*SPEED
	velocity.z = direction.z*SPEED

	if !self.is_on_floor() :
		velocity.y -= GRAVITY*delta
	move_and_slide()
		
