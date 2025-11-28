class_name Player extends CharacterBody3D

const RAYLENGTH : int = 100
const GRAVITY : float = 4
const TWEEN_DURATION : float = 1.0

@onready var HUD : hud = get_node("HUD")
@onready var inventory : Inventory = get_node("Inventory")
@onready var pause_menu : pause = get_node("pause_menu")
@onready var navAgent := $NavigationAgent3D
@export var speed : int = 4

var item_lo : PackedScene
var instance_item : item
# var instance_pause : pause = pause_menu.instantiate()
var cam : Camera3D
var npc_trigger_entered : bool = false
var item_trigger_entered : bool = false
var skip_rayQuery : bool = false
@onready var dernier_item : int = inventory.get_node("inventory_container").get_child_count()
	
#Fonctions communes
func _physics_process(delta : float) -> void :
	if (navAgent.is_navigation_finished()) :
		return
	moveToPoint(delta)

func _ready() -> void :
	HUD.contain_menu.hide()
	inventory.hide()
	

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

			var transition : Tween = create_tween()
			
			transition.tween_property(camTrans, "global_position", cam.global_position, TWEEN_DURATION)
			transition.parallel().tween_property(camTrans, "rotation", cam.rotation, TWEEN_DURATION)

			transition.tween_callback(Callable(cam, "make_current"));
		else : 
			cam.make_current()

func enter_trigger_npc(_area : Area3D) -> void :
	npc_trigger_entered = true

func exit_trigger_npc(area : Area3D) -> void:
	area.owner.get_node("Text_box").hide()
	npc_trigger_entered = false

func enter_trigger_item(area : Area3D) -> void :
	item_trigger_entered = true
	item_lo = load("res://scenes/Items/" + area.owner.get_scene_name())
	instance_item = item_lo.instantiate()
	add_item(instance_item)

func exit_trigger_item(area : Area3D) -> void :
	item_trigger_entered = false
	if instance_item.is_in_container :
		area.owner.queue_free()
		remove_item(inventory.get_child(dernier_item))


#Input
func _input(_event:InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") :
		if skip_rayQuery or inventory.visible:
			return

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
				self.skip_movement()
				interactWith(collider)
			else : 
				navAgent.set_target_position(ray.position)
			
		if collider.get_parent().get_parent() is NavigationRegion3D :
				navAgent.set_target_position(ray.position)

	if Input.is_action_just_pressed("escape") :
		if HUD.contain_menu.visible:
			HUD.contain_menu.hide()
		else :
			if self.get_child_count() == 7 and self.get_child(6).visible :
				self.get_child(6).hide()
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

func skip_movement() -> void :
	return

func add_item(p_item : item) -> void :
	inventory.get_node("inventory_container").add_child(p_item)

func remove_item(p_item : item) -> void :
	inventory.get_node("inventory_container").remove_child(p_item)




		
