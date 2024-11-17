extends Node3D

var mouse_input := Vector2.ZERO
var dir := Vector3.ZERO
var move_input := Vector2.ZERO
var view_sensitivity:float = 0.5

@onready var cam_pitch = $SpringArm3D/CameraPosition
@onready var cam_yaw = $yaw


func camera_move():

	dir += move_input.x * cam_yaw.global_transform.basis.x;
	dir -= move_input.y * cam_yaw.global_transform.basis.z;
	#
	#cam_pitch.rotation_degrees.x -= mouse_input.y * view_sensitivity * delta;
	#cam_pitch.rotation_degrees.x = clamp(cam_pitch.rotation_degrees.x,-80,80)
	#cam_pitch.rotation_degrees.y -= mouse_input.x * view_sensitivity * delta;
	#mouse_input =Vector2.ZERO
