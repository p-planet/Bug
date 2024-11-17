extends RigidBody3D
class_name Bug


@export var max_speed:float = 50.0
@export var acceleration:float = 10
@export var on_floor:bool = false
@export var dir:Vector3 = Vector3.ZERO
@export var ump_power:float = 5.0
#@export var
#@export var

@export var jump_velocity: int = 10
@export var speed: float  = 25.0
var accel_multiplier: int = 1
@export var stop_speed: float = 0.1

var velocity := Vector3.ZERO

var mouse_input: Vector2 = Vector2()
@onready var cam_pitch = $CameraPivot
@onready var cam_yaw = $CameraPivot/SpringArm3D/CameraPosition
@onready var feet = $RigidFeet
@onready var feet_ray = $RayFeet
@onready var friction: float = physics_material_override.friction
@export var view_sensitivity: float = 10.0
@export var move_sensitivity: float = 0.5
var move_input := Vector2.ZERO

# Arrays to store contact points and normals
var contact_points: Array = []
var contact_normals: Array = []

func _ready():
	linear_damp = 0.0
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _physics_process(delta):
	#camera_move()
	# reset friction to zero to avoid sticking to walk when velocity is applied
	if on_floor: friction = 0
	on_floor = false
	var dir: Vector3 = Vector3.ZERO
	# movement input

	velocity = lerp(velocity,dir*speed,acceleration*accel_multiplier*delta)
	apply_central_force(velocity)
	if feet_ray.is_colliding():
		on_floor = true
		friction = 1.0
		accel_multiplier = 1.0
	if Input.is_action_just_pressed("jump") and on_floor:
		accel_multiplier = 0.1
		on_floor = false
		apply_central_impulse(Vector3.UP * jump_velocity)
	# view and rotation

	

func _integrate_forces(state):
	# limit max speed
	if state.linear_velocity.length()>max_speed:
		state.linear_velocity=state.linear_velocity.normalized()*max_speed
	# artificial stopping movement i.e not using physics
	if move_input.length() < 0.2:
		state.linear_velocity.x = lerp(state.linear_velocity.x, 0.0, stop_speed)
		state.linear_velocity.z = lerp(state.linear_velocity.z, 0.0, stop_speed)
	# push against floor to avoid sliding on "unreasonable" slopes
	if state.get_contact_count() > 0 and move_input.length()< 0.2:
		if on_floor and state.get_contact_local_normal(0).y < 0.9:
			apply_central_force(-state.get_contact_local_normal(0)*10)
			
	contact_points.clear()
	contact_normals.clear()

	# Collect contacts
	for i in range(state.get_contact_count()):
		contact_points.append(state.get_contact_position(i))
		contact_normals.append(state.get_contact_normal(i))
	
	# Process collected contacts (example operation)
	for contact_normal in contact_normals:
			if contact_normal.y < 0.9 and move_input.length() < 0.2:
				apply_central_force(-contact_normal * 10)


# mouse input
#func camera_move():
#
	#dir += move_input.x * cam_yaw.global_transform.basis.x;
	#dir -= move_input.y * cam_yaw.global_transform.basis.z;

	
