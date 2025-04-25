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
			
			#springArm.spring_length = 0
			#teleport_player_relative_to_object(Vector3(0, 0, -1))
			
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
	
	# commented because they were causing me errors
	# Set the player's position relative to the target
	#player.global_position = position + offset
	#print("New Player Position: ", player.global_position)

#dialog functions for village drunk
func randomDialog():
	Dialogic.timeline_ended.connect(ended_dialog)
	var dialog_line = randi_range(1,4)
	Dialogic.start("VillageDrunkTimeline"+str(dialog_line))
	
func ended_dialog():
	Dialogic.timeline_ended.disconnect(ended_dialog)
	
