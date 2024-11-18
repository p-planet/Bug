extends Node3D
class_name CameraControl

var mouse_input := Vector2.ZERO
var dir := Vector3.ZERO
var move_input := Vector2.ZERO
var view_sensitivity:float = 0.5

@onready var bugcam = %BugCam
@onready var cam_yaw = $yaw
@onready var cam_target = $CameraTarget
@onready var cam_pitch = $yaw/SpringArm3D
@onready var cam_pos = $yaw/SpringArm3D/CameraPosition 

func _ready() -> void:
	bugcam.set_cam_pos(cam_pos)
	bugcam.set_cam_target(cam_target)
	
func _physics_process(delta: float) -> void:
	camera_move(delta)

func camera_move(delta:float):
	mouse_input = controls.mouse_input
	
	dir += move_input.x * bugcam.global_transform.basis.x;
	dir -= move_input.y * bugcam.global_transform.basis.z;
	
	mouse_input *= view_sensitivity
	print(mouse_input)
	
	cam_pitch.rotation_degrees.x -= mouse_input.y
	cam_pitch.rotation_degrees.x = clamp(cam_pitch.rotation_degrees.x,-80,80)
	cam_yaw.rotation_degrees.y -= mouse_input.x 
	print(cam_yaw.rotation_degrees.y)
	controls.mouse_input *= 0
