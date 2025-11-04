class_name Player extends CharacterBody3D

const RAYLENGTH : int = 100
const GRAVITY : float = 4
const TWEEN_DURATION : float = 1.0
const HUD : PackedScene = preload("res://scenes/Menus/hud.tscn")
const pause_menu : PackedScene = preload("res://scenes/Menus/pause_menu.tscn")

var instance_pause : pause = pause_menu.instantiate()
var instance_hud : hud = HUD.instantiate()
var cam : Camera3D
var npc_trigger_entered : bool = false

@onready var navAgent := $NavigationAgent3D
@export var speed : int = 4
		
#Fonctions communes
func _physics_process(delta : float) -> void :
	if (navAgent.is_navigation_finished()) :
		return
	moveToPoint(delta)

func _ready() -> void :
	self.add_child(instance_hud)

#Fonction entrer dans zone	
func enter_trigger_camera(area : Area3D) -> void:
	var camOrigin : Camera3D = get_viewport().get_camera_3d()
	cam = area.get_child(1)

	if !cam.current && camOrigin.current :
		if cam.has_transition :
			var camTrans : Camera3D = camOrigin.duplicate()
			owner.add_child(camTrans)
			camTrans.global_position = camOrigin.global_position
			camTrans.make_current()

			var transPos : Tween = create_tween()
			var transRot : Tween = create_tween()
			
			transPos.tween_property(camTrans, "global_position", cam.global_position, TWEEN_DURATION)
			transRot.tween_property(camTrans, "rotation", cam.rotation, TWEEN_DURATION)

			transRot.tween_callback(Callable(cam, "make_current"));
		else : 
			cam.make_current()

func enter_trigger_npc(_area : Area3D) -> void :
	npc_trigger_entered = true

func exit_trigger_npc(area : Area3D) -> void:
	area.owner.get_node("Text_box").hide()
	npc_trigger_entered = false

#Input
func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") :

		var mousePos : Vector2 = get_viewport().get_mouse_position()
		var from : Vector3 = cam.project_ray_origin(mousePos)
		var to : Vector3= from + cam.project_ray_normal(mousePos) * RAYLENGTH
		var space : PhysicsDirectSpaceState3D= get_world_3d().direct_space_state
		var rayQuery : PhysicsRayQueryParameters3D= PhysicsRayQueryParameters3D.create(from, to)
		
		var ray : Dictionary = space.intersect_ray(rayQuery)
		if ray.is_empty() :
			return

		var collider : Node3D = ray.collider
		if collider is npc :
			if npc_trigger_entered :
				skip_movemvent()
				interactWith(collider)
			else : 
				navAgent.set_target_position(ray.position)
			

		if collider.get_parent().get_parent() is NavigationRegion3D :
				navAgent.set_target_position(ray.position)

	if Input.is_action_just_pressed("escape") :
		if instance_hud.contain_menu.visible :
			instance_hud.contain_menu.hide()
		else :
			get_tree().paused = true
			self.add_child(instance_pause)
			instance_pause = pause_menu.instantiate()

#Fonctions définies
func moveToPoint(delta : float) -> void :
	var targetPos : Vector3 = navAgent.get_next_path_position()
	var direction : Vector3= global_position.direction_to(targetPos)
	velocity.x = direction.x*speed
	velocity.z = direction.z*speed
	if !self.is_on_floor() :
		velocity.y -= GRAVITY*delta
	move_and_slide()

func interactWith(target : Node3D) -> void :
	if target is npc :
		target.displayDialog()

func skip_movemvent() -> void :
	return


		
