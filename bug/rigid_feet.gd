extends RigidBody3D
class_name RigidFeet

var contacts:Array 


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	#contacts = state.get_contact_count()
	pass
