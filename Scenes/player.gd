extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var pivot = $CameraOrigin
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	# Animal Crossing camera setup
	$CameraOrigin/SpringArm3D/Camera3D.current = true
	$CameraOrigin/SpringArm3D.spring_length = 5.0
	$CameraOrigin/SpringArm3D.rotation_degrees = Vector3(-45, 0, 0)
	
	# Disable mouse look for AC-style
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	# Get the input direction
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	# Animal Crossing style movement (relative to camera)
	var camera_basis = $CameraOrigin/SpringArm3D/Camera3D.global_transform.basis
	var direction = Vector3.ZERO
	direction = (camera_basis.z * input_dir.y + camera_basis.x * input_dir.x)
	direction.y = 0  # Keep movement on the horizontal plane
	direction = direction.normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
	# Make camera follow player position but not rotation
	$CameraOrigin.global_position = global_position
