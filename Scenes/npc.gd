extends Area3D

@onready var springArm = get_node_or_null("/root/KingdomSpawn/Player/CameraOrigin/Horizontal/Vertical/SpringArm3D")
@onready var player = get_node_or_null("/root/KingdomSpawn/Player/PlayerBody")

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)


var inside = false
var bodyName
func _on_body_entered(body):
	bodyName = body.name
	print(body.name, " is in front of npc")
	if (bodyName == "PlayerBody"):
		inside = true

func _on_body_exited(body):
	print(body.name, " is not in front of npc")
	if (bodyName == "PlayerBody"):
		inside = false
	
func _process(delta: float) -> void:
	if inside:
		if Input.is_action_just_pressed("interact"):
			print("interacted")
			springArm.spring_length = 0
			teleport_player_relative_to_object(Vector3(0, 0, -1))
# Function to teleport player relative to target object
func teleport_player_relative_to_object(offset: Vector3):
	# Get the current position of the target object
	var position = global_position
	print("Target Position: ", position)
	# Set the player's position relative to the target
	player.global_position = position + offset
	print("New Player Position: ", player.global_position)
