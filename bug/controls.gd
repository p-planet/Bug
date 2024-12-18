extends Node
class_name BugControl

var mouse_input := Vector2.ZERO
var left_stick_input := Vector2.ZERO
var right_stick_input := Vector2.ZERO
@export var move_sensitivity : float = 0.5
@export var lerp_stick_on : bool = false
@export var lerp_stick_two : bool = false


@export var bugcam : BugCam 
@export var bugcam_controller : CameraControl
@export var bug : BugBody3D

const InputType = InputController.InputType
@onready var input_controller:InputController = $InputController



func _ready():
	input_controller.input_detected.connect(_on_input_detected)
	
func _on_input_detected(event: InputEvent, action: String, input_type: InputType):
	match input_type:
		InputType.TAP:
			prints(action, "tapped")
		InputType.DOUBLE_TAP:
			prints(action, "double tapped")
		InputType.PRESS:
			prints(action, "pressed")
		InputType.LONG_PRESS:
			prints(action, "long pressed")
		InputType.HOLD:
			prints(action, "held")
	
enum PlayerAction {
	HOP,
	DUCK,
	CROUCH,
	BITE,
	GRAB,
	STOP,
	GO,
}

signal action(action:int)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input = event.relative;
	left_stick_input = Input.get_vector("left","right","down","up")
	right_stick_input = Input.get_vector("look left", "look right", "look down", "look up")
	var move_input2 = lerp(Vector2.ZERO, left_stick_input, move_sensitivity)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
		Input.set_mouse_mode(2)
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(0)
