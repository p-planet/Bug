extends Camera3D
class_name BugCam

@export var cam_pos : Node3D
@export var cam_target : Node3D

func set_cam_pos(new_pos:Node3D):
	cam_pos = new_pos

func set_cam_target(new_cam_target:Node3D):
	cam_target = new_cam_target

func _process(delta: float) -> void:
	if cam_target is Node3D:
		look_at(cam_target.position)
	if cam_pos is Node3D:
		position = cam_pos.global_position
		rotation = cam_pos.global_rotation
