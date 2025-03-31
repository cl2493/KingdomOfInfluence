extends Node3D

@export var player: CharacterBody3D
@export var follow_speed = 5.0
@export var sensitivity = 0.005

var rotation_x = 0.0

func _ready():
	# Set up camera properties
	$SpringArm3D/Camera3D.current = true
	$SpringArm3D.spring_length = 5.0
	$SpringArm3D.rotation_degrees = Vector3(-45, 0, 0)
	
func _process(delta):
	if player:
		# Follow the player smoothly without rotation influence
		global_position = lerp(global_position, player.global_position, follow_speed * delta)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_x -= event.relative.y * sensitivity
		rotation_x = clamp(rotation_x, -75, 75)  # Limit vertical rotation
		rotation.y -= event.relative.x * sensitivity

	# Apply rotation only to the camera, NOT the player
	rotation_degrees.x = rotation_x
