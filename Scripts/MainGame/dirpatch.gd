extends Area3D

@export var stageA: Texture2D
@export var stageB: Texture2D




func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

var inside = false
var bodyName
func _on_body_entered(body):
	bodyName = body.name
	print(body.name, " entered the area!")
	if (bodyName == "PlayerBody"):
		inside = true

func _on_body_exited(body):
	print(body.name, " left the area!")
	if (bodyName == "PlayerBody"):
		inside = false
	
func _process(delta: float) -> void:
	if inside:
		if Input.is_action_just_pressed("interact"):
			print("interacted")
			if $wheat/stageB:
				removeCrop()
			else:
				
				plantWheat()
			
func removeCrop():
	var wheat = $wheat/stageB  # Reference the node
	if wheat:
		wheat.queue_free()  # Delete it safely



func plantWheat():
	var seed = preload("res://assests/nature/instances/crops_wheatStageA.glb")  # Load the scene
	var wheat = seed.instantiate()  # Create an instance
	wheat.position = Vector3(0, 0, 0)  # Set position
	add_child(wheat)  # Add it to the scene tree
