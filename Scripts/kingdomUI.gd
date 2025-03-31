extends Button

var currentUI
var nextUI


	

func kingdomUI():
		# set meshes
	var player = get_tree().current_scene.get_node("Node3D/Player")
	player.apply_customization()

	var result = get_tree().change_scene_to_file("res://Scenes/KingdomSpawn.tscn")
	if result != OK:
		print("Error changing scene: " + str(result))
	else:
		print("Scene change successful")
