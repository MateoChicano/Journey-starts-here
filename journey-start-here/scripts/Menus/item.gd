class_name item extends RigidBody2D

@export var item_name : String
@export var item_description : String

var mouse_left_down: bool = false
var mouse_force : float = 15
var mouse_position : Vector2
var previous_pos : Vector2
var is_body_entered : bool


func _input( event:InputEvent ) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			mouse_left_down = true
			# previous_pos = get_viewport().get_mouse_position()
			# print("pos prec:", previous_pos)
			self.gravity_scale = 0
			self.linear_velocity.x = 0
			self.linear_velocity.y = 0
			
			
			
			
			
		elif event.button_index == 1 and not event.is_pressed():
			mouse_left_down = false
			# self.linear_velocity = previous_pos - self.global_position
			# print("force", self.linear_velocity)
			self.gravity_scale = 1.0
			
			
			
func _physics_process(delta: float) -> void:
	if mouse_left_down :
		mouse_position = get_viewport().get_mouse_position()
		self.global_position = self.global_position.lerp(mouse_position, mouse_force * delta)
		# print("new pos :", self.global_position)

func mouse_in_body() -> void :
		is_body_entered = true
		print("entered")

func mouse_off_body() -> void:
		is_body_entered = false
		print("exited")
