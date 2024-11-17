extends Camera3D
class_name BugCam

var cam_pos = Node3D
var cam_target = Node3D

func set_cam_pos(new_pos:Node3D):
	cam_pos = new_pos

func set_cam_target(new_cam_target:Node3D):
	cam_target = new_cam_target

func _process(delta: float) -> void:
	if cam_target != null:
		look_at(cam_target)
	if cam_pos != null:
		position = cam_pos.position
		rotation = cam_pos.rotation
