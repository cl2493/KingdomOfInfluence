extends CharacterBody3D

@export var camera_origin: Node3D  # Drag and drop CameraOrigin in the Inspector

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	# Get input direction
	var input_dir = Input.get_vector("left", "right", "up", "down")

	# Get camera basis for movement
	if camera_origin:
		var camera_basis = camera_origin.global_transform.basis
		var direction = (camera_basis.z * input_dir.y + camera_basis.x * input_dir.x)
		direction.y = 0  # Keep movement on the horizontal plane
		direction = direction.normalized()

		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED

			# Rotate character to face movement direction
			var target_rotation = atan2(direction.x, direction.z)
			rotation.y = lerp_angle(rotation.y, target_rotation, 10 * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
 
		# Fix: Make CameraOrigin follow Player without inheriting rotation
		camera_origin.global_position = global_position
		camera_origin.rotation = Vector3.ZERO  # Ensure no unwanted rotation
