extends Area3D


@onready var springArm = get_node_or_null("/root/world/PlayerMovement/CameraOrigin/Horizontal/Vertical/SpringArm3D")
@onready var player = get_node_or_null("/root/world/PlayerMovement/Player")
@onready var camH= get_node_or_null("/root/world/PlayerMovement/CameraOrigin/Horizontal")
var rotationOverride
func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	if springArm == null:
		print("No arm")
	if player == null:
		print("no player")

var inside = false
var bodyName
func _on_body_entered(body):
	bodyName = body.name
	if (bodyName == "Player"):
		get_node("/root/Global").current_npc = self
		Dialogic.paused = false
		inside = true
		print(body.name, " is in front of ", self.name)

func _on_body_exited(body):
	print(body.name, " is not in front of npc")
	if (bodyName == "Player"):
		Dialogic.paused = true
		Dialogic.clear()
		get_node("/root/Global").current_npc = null
		inside = false
	
func _process(delta: float) -> void:
	if inside:
		if Input.is_action_just_pressed("interact"):
			print("interacted")
			determineNPCDialog()
			teleport_player_relative_to_object(Vector3(0, 0, -2))
						# Shorten the camera arm
			springArm.spring_length = 0
			rotationOverride = true
			rotationOverride = true

			# Get the NPC's position
			var npcPos = global_transform.origin

			# Calculate direction from camH to the NPC
			var direction = (npcPos - camH.global_transform.origin).normalized()

			# Calculate the yaw (horizontal rotation) and pitch (vertical rotation)
			var yaw = atan2(direction.x, direction.z)  # For horizontal rotation (around Y)
			var pitch = asin(direction.y)  # For vertical rotation (around X)

			# Apply yaw (horizontal rotation)
			camH.rotation.y = yaw - deg_to_rad(180)  # Subtract 180 degrees to fix the 180-degree flip

			# Apply pitch (vertical rotation)
			camH.rotation.x = -pitch  # Typically negative for proper camera tilt

	else:
		rotationOverride = false	
			
func determineNPCDialog():
	match Global.current_npc.name:
		"DrunkardNPC":
			randomDialog()
		"FarmerNPC":
			print("We farming")
		_:
			print("TODO")
# Function to teleport player relative to target object
func teleport_player_relative_to_object(offset: Vector3):
	# Get the current position of the target object
	var position = global_position
	print("Target Position: ", position)
	
	
	#Set the player's position relative to the target
	player.global_position = position + offset
	print("New Player Position: ", player.global_position)

#dialog functions for village drunk
func randomDialog():
	Dialogic.timeline_ended.connect(ended_dialog)
	var dialog_line = randi_range(1,4)
	Dialogic.start("VillageDrunkTimeline"+str(dialog_line))
	
func ended_dialog():
	Dialogic.timeline_ended.disconnect(ended_dialog)
	
