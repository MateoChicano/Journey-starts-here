class_name Player extends CharacterBody3D

const RAYLENGTH: int = 100
const GRAVITY: float = 4
const TWEEN_DURATION: float = 0.5

@onready var HUD: Hud = get_node("HUD")
@onready var inventory: Inventory = get_node("Inventory")
@onready var pause_menu: Pause = get_node("pause menu")
@onready var navAgent := $NavigationAgent3D
@onready var dernier_item: int = inventory.get_node("inventory_container").get_child_count()
@export var speed: int = 4

var step: float = speed / 50.0
var can_interact : bool = true
var input_axis: Vector2
var item_lo: PackedScene
var instance_item: Item
var cam: Camera3D
var interactable_npc: Npc
var npc_trigger_entered: bool = false
var item_trigger_entered: bool = false
var skip_rayQuery: bool = false

	
#Fonctions communes
func _physics_process(delta: float) -> void:
	if (navAgent.is_navigation_finished()):
		return
	if ! self.is_on_floor():
		velocity.y -= GRAVITY * delta
	input_axis = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	moveToPoint()
	moveWithKeys()

func _ready() -> void:
	HUD.contain_menu.hide()
	inventory.hide()
	pause_menu.hide()
	

#Fonctions trigger
#Gère les fonctions liés à  des détection de Area
func enter_trigger_camera(area: Area3D) -> void:
	var camOrigin: Camera3D = get_viewport().get_camera_3d()
	cam = area.get_child(1)

	if !cam.current && camOrigin.current:
		if cam.has_transition:
			var camTrans: Camera3D = camOrigin.duplicate()
			owner.add_child(camTrans)
			camTrans.global_position = camOrigin.global_position
			camTrans.make_current()

			var transition: Tween = create_tween()
			
			transition.tween_property(camTrans, "global_position", cam.global_position, TWEEN_DURATION).set_trans(Tween.TRANS_SINE)
			transition.parallel().tween_property(camTrans, "rotation", cam.rotation, TWEEN_DURATION).set_trans(Tween.TRANS_SINE)

			transition.tween_callback(Callable(cam, "make_current"));
		else:
			cam.make_current()

func enter_trigger_npc(area: Area3D) -> void:
	interactable_npc = area.owner
	npc_trigger_entered = true

func exit_trigger_npc(area: Area3D) -> void:
	area.owner.closeDialogBox()
	npc_trigger_entered = false

func enter_trigger_item(area: Area3D) -> void:
	item_trigger_entered = true
	instance_item = area.owner.get_item_2d()
	instance_item.just_spawned = true
	instance_item.instance_3d = area.owner
	pick_item(instance_item)

func exit_trigger_item(_area: Area3D) -> void:
		item_trigger_entered = false
		if not instance_item.is_in_container:
			instance_item.queue_free()
			HUD.inventory_notif.hide()


#Input
#Gère les fonctions liés à des entrées clavier ou souris
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		if skip_rayQuery or inventory.visible:
			return

		var mousePos: Vector2 = get_viewport().get_mouse_position()
		var from: Vector3 = cam.project_ray_origin(mousePos)
		var to: Vector3 = from + cam.project_ray_normal(mousePos) * RAYLENGTH
		var space: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
		var rayQuery: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(from, to)
		
		var ray: Dictionary = space.intersect_ray(rayQuery)
		if ray.is_empty():
			return

		var collider: Node3D = ray.collider
		if collider is Npc:
			if npc_trigger_entered and interactable_npc == collider:
				self.skip_movement()
				interactWithNpc(collider)
			else:
				navAgent.set_target_position(ray.position)
			
		if collider.get_parent().get_parent() is NavigationRegion3D:
				navAgent.set_target_position(ray.position)

	if Input.is_action_just_pressed("escape"):
		if HUD.contain_menu.visible:
			HUD.contain_menu.hide()
		if inventory.visible:
			inventory.quit_inventory()
		else:
			if pause_menu.visible:
				pause_menu.quit_menu()
			else:
				pause_menu.show()
				get_tree().paused = true

#Fonctions custom
func moveToPoint() -> void:
	var targetPos: Vector3 = navAgent.get_next_path_position()
	var direction: Vector3 = global_position.direction_to(targetPos)
	rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z), TWEEN_DURATION)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed 


func interactWithNpc(target: Npc) -> void:
			if can_interact :
				can_interact = false
				target.displayDialog()

func skip_movement() -> void:
	return

func pick_item(p_item: Item) -> void:
	inventory.get_node("Items").add_child(p_item)
	HUD.inventory_notif.show()

func moveWithKeys() -> void:
	var direction: Vector2 = Vector2.ZERO
	direction.x += input_axis.x * cos(cam.global_rotation.y) + input_axis.y * sin(cam.global_rotation.y);
	direction.y += input_axis.y * cos(cam.global_rotation.y) + input_axis.x * sin(cam.global_rotation.y);
	direction = direction.normalized();

	if Input.is_action_pressed("up"):
		navAgent.target_position.x += direction.x * step
		navAgent.target_position.z += direction.y * step
	if Input.is_action_pressed("down"):
		navAgent.target_position.x += direction.x * step
		navAgent.target_position.z += direction.y * step
	if Input.is_action_pressed("left"):
		navAgent.target_position.z -= direction.y * step
		navAgent.target_position.x += direction.x * step
	if Input.is_action_pressed("right"):
		navAgent.target_position.z -= direction.y * step
		navAgent.target_position.x += direction.x * step
	move_and_slide()
